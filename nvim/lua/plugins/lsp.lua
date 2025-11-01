return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            {
                "mason-org/mason.nvim",
                opts = {},
            },
            -- "hrsh7th/cmp-nvim-lsp",
            "saghen/blink.cmp",
            "mason-org/mason-lspconfig.nvim",
            {
                "j-hui/fidget.nvim",
                event = { "LspAttach" },
                opts = {
                    -- Add 'NvimTree' to the 'notification.window.avoid' list to ensure Fidget continues to avoid nvim-tree.lua's file explorer.
                    notification = {
                        window = {
                            avoid = {
                                "NvimTree",
                            },
                        },
                    },
                },
            },
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
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
                        local highlight_augroup =
                            vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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

            -- blink-cmp

            local original_capabilities = vim.lsp.protocol.make_client_capabilities()
            local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

            -- nvim-cmp

            -- local original_capabilities = vim.lsp.protocol.make_client_capabilities()
            -- local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- local capabilities = vim.tbl_deep_extend("force", original_capabilities, cmp_capabilities)

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
                "isort",
                "pylint",
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
                    "emmet_language_server",
                    "prismals",
                    "pyright",
                    "eslint",
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

            vim.lsp.config("ts_ls", {
                settings = {
                    typescript = {
                        preferences = {
                            disableSuggestions = true,
                        },
                    },
                    javascript = {
                        preferences = {
                            disableSuggestions = true,
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
                        return " " .. diagnostic.message .. " "
                    end,
                },
            })

            local keymap = vim.keymap

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }

                    opts.desc = "Show LSP references"
                    keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

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
    },
}
