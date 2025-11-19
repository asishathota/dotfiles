return {
    -- {
    --     "NvChad/nvim-colorizer.lua",
    --     event = { "BufReadPost", "BufNewFile" },
    --     opts = {
    --         user_default_options = {
    --             names = false, -- no named colors (optional)
    --             RGB = true,
    --             RRGGBB = true,
    --             RRGGBBAA = true,
    --             tailwind = true, -- important for Tailwind classes
    --             css = true,
    --             mode = "virtualtext",
    --         },
    --     },
    -- },

    -- Tailwind colorized completion ONLY (NOT buffer highlighting)
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end,
    },
}
