return {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("nvim-highlight-colors").setup({
            render = "virtual",
            virtual_symbol = "",
            virtual_symbol_prefix = "",
            virtual_symbol_suffix = " ",
            virtual_symbol_position = "inline",
        })
    end,
}

-- return {
--     "brenoprata10/nvim-highlight-colors",
--     event = { "BufReadPre", "BufNewFile" },
--     config = function()
--         local highlight_colors = require("nvim-highlight-colors")
--         if highlight_colors then
--             highlight_colors.setup({
--                 render = "virtual",
--                 virtual_symbol = "",
--                 virtual_symbol_prefix = " ",
--                 virtual_symbol_suffix = " ",
--                 virtual_symbol_position = "inline",
--             })
--         else
--             print("nvim-highlight-colors not found!")
--         end
--     end,
-- }
