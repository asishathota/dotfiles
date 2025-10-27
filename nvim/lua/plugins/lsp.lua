return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "j-hui/fidget.nvim",
            event = { "LspAttach" },
            opts = {},
        },
        "saghen/blink.cmp",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
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

        local capabilities = require("blink.cmp").get_lsp_capabilities()

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
            "black",
            "pylint",
            "eslint_d",
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
                "graphql",
                "emmet_ls",
                "prismals",
                "pyright",
            },
            automatic_installation = false,
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    vim.lsp[server_name].setup(server)
                end,
            },
        })

        vim.diagnostic.config({
            severity_sort = true,
            float = { border = "rounded", source = "if_many" },
            underline = { severity = vim.diagnostic.severity.ERROR },
            update_in_insert = false,
            signs = vim.g.have_nerd_font and {
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚 ",
                    [vim.diagnostic.severity.WARN] = "󰀪 ",
                    [vim.diagnostic.severity.INFO] = "󰋽 ",
                    [vim.diagnostic.severity.HINT] = "󰌶 ",
                },
            } or {},
            virtual_text = {
                source = "if_many",
                severity = { min = vim.diagnostic.severity.WARN },
                prefix = "", -- ■ 
                suffix = "",
                spacing = 2,
                format = function(diagnostic)
                    -- local diagnostic_message = {
                    --     [vim.diagnostic.severity.ERROR] = diagnostic.message,
                    --     [vim.diagnostic.severity.WARN] = diagnostic.message,
                    --     [vim.diagnostic.severity.INFO] = diagnostic.message,
                    --     [vim.diagnostic.severity.HINT] = diagnostic.message,
                    -- }
                    -- return " " .. diagnostic_message[diagnostic.severity] .. " "
                    return " " .. diagnostic.message .. " "
                end,
            },
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        local keymap = vim.keymap

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definition"
                keymap.set("n", "gd", vim.lsp.buf.definition, opts)

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", function()
                    vim.diagnostic.jump({ count = -1, float = true })
                end, opts)

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", function()
                    vim.diagnostic.jump({ count = 1, float = true })
                end, opts)

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
            end,
        })
    end,
}
