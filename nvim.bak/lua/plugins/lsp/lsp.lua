return {
    "hrsh7th/cmp-nvim-lsp",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/lazydev.nvim", opts = {} },
    },
    config = function()
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_nvim_lsp.default_capabilities()

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        vim.diagnostic.config({
            virtual_text = {
                spacing = 2,
                severity = { min = vim.diagnostic.severity.WARN },
                prefix = "", -- ■ 
                suffix = "",
                format = function(diagnostic)
                    return " " .. diagnostic.message .. " "
                end,
            },
            signs = false,
            underline = {
                severity = vim.diagnostic.severity.ERROR,
            },
            update_in_insert = false,
        })
    end,
}
