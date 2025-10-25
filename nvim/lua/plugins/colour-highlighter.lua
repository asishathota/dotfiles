return {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile", "InsertEnter" },
    config = function()
        vim.opt.termguicolors = true
        require("nvim-highlight-colors").setup({
            render = "virtual",
            virtual_symbol = "",
            virtual_symbol_position = "inline",
            enable_tailwind = true,
            enable_rgb = true,
            enable_hex = true,
            enable_named_colors = true,
            enable_var_usage = true,
            enable_hsl = true,
        })
    end,
}
