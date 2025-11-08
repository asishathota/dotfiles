return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "mason-org/mason.nvim",
            opts = {},
        },
        "hrsh7th/cmp-nvim-lsp",
        -- "saghen/blink.cmp",
        { "antosha417/nvim-lsp-file-operations", event = "VimEnter", config = true },
        "mason-org/mason-lspconfig.nvim",
        -- {
        --     "folke/lazydev.nvim",
        --     ft = "lua", -- only load on lua files
        --     opts = {
        --         library = {
        --             { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        --         },
        --     },
        -- },
    },

    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                local function client_supports_method(client, method, bufnr)
                    if vim.fn.has("nvim-0.11") == 1 then
                        return client:supports_method(method, bufnr)
                    else
                        return client.supports_method(method, { bufnr = bufnr })
                    end
                end

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if
                    client
                    and client_supports_method(
                        client,
                        vim.lsp.protocol.Methods.textDocument_documentHighlight,
                        event.buf
                    )
                then
                    vim.opt_local.updatetime = 3000
                    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                        end,
                    })
                end
            end,
        })

        -- assigning capabilities to completion engine

        -- local original_capabilities = vim.lsp.protocol.make_client_capabilities()
        -- local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

        -- nvim-cmp

        local original_capabilities = vim.lsp.protocol.make_client_capabilities()
        local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
        local capabilities = vim.tbl_deep_extend("force", original_capabilities, cmp_capabilities)

        local servers = {
            cssls = {},
            emmet_language_server = {},
            html = {},
            stylua = {},
            tailwindcss = {},
            ts_ls = {},
            jdtls = {},
            lua_ls = {},
        }

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua",
            "prettier",
            "eslint_d",
            "google-java-format",
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "ts_ls",
                "html",
                "cssls",
                "tailwindcss",
                "svelte",
                "lua_ls",
                "jdtls",
                "graphql",
                "emmet_ls",
                "prismals",
            },
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = {
                        version = "Lua 5.3",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        vim.diagnostic.config({
            severity_sort = true,
            float = { border = "rounded", source = "if_many" },
            underline = { severity = vim.diagnostic.severity.ERROR },
            update_in_insert = false,
            -- signs = vim.g.have_nerd_font and {
            -- 󰅚 󰀪 󰋽 󰌶
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                    [vim.diagnostic.severity.HINT] = " ",
                },
            } or {},
            virtual_text = {
                source = "if_many",
                severity = { min = vim.diagnostic.severity.WARN },
                prefix = "", -- ■ 
                suffix = "",
                spacing = 2,
                format = function(diagnostic)
                    local diagnostic_message = {
                        [vim.diagnostic.severity.ERROR] = diagnostic.message,
                        [vim.diagnostic.severity.WARN] = diagnostic.message,
                        [vim.diagnostic.severity.INFO] = diagnostic.message,
                        [vim.diagnostic.severity.HINT] = diagnostic.message,
                    }
                    return " " .. diagnostic_message[diagnostic.severity]
                    -- return " " .. diagnostic.message .. " "
                end,
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                map("gr", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
                map("gD", vim.lsp.buf.declaration, "Go to declaration")
                map("gd", vim.lsp.buf.definition, "Show LSP definition")
                map("gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
                map("gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
                map("<leader>ca", vim.lsp.buf.code_action, "See available code actions", { "n", "v" })
                map("<leader>rn", vim.lsp.buf.rename, "Smart rename")
                map("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
                map("<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
                map("[d", function()
                    vim.diagnostic.jump({ count = -1, float = true })
                end, "Go to previous diagnostic")
                map("]d", function()
                    vim.diagnostic.jump({ count = 1, float = true })
                end, "Go to next diagnostic")
                map("K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
                map("<leader>rs", ":LspRestart<CR>", "Restart LSP")
            end,
        })
    end,
}
