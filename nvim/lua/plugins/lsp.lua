return {
    {
        "mason-org/mason.nvim",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },

        config = function()
            require("mason").setup({})

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ts_ls",
                    "tailwindcss",
                    "lua_ls",
                    "html",
                    "cssls",
                    "emmet_language_server",
                    "prismals",
                },
            })
        end,

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {
                            "vim",
                        },
                    },
                },
            },
        }),
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "prettier",
                "stylua",
                "isort",
                "black",
                "pylint",
                "eslint_d",
                "google-java-format",
            },
        },
        dependencies = {
            "mason-org/mason.nvim",
        },
    },
}
