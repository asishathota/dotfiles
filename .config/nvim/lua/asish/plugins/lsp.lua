return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- event = "VimEnter",
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
        local original_capabilities = vim.lsp.protocol.make_client_capabilities()

        --blink cmp
        -- local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

        -- nvim-cmp
        local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
        local capabilities = vim.tbl_deep_extend("force", original_capabilities, cmp_capabilities)

        capabilities.textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
            completionItem = {
                snippetSupport = false,
            },
        }

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
    end,
}
