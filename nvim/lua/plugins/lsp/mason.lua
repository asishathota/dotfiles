return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "ts_ls",
                "tailwindcss",
                "lua_ls",
                "html",
                "cssls",
                "emmet_language_server",
                "prismals",
                "eslint",
            },
        },
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = {},
            },
            "neovim/nvim-lspconfig",
        },
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
