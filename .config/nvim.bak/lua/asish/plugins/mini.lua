return {
    {
        "nvim-mini/mini.pairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "nvim-mini/mini.ai",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
    {
        "nvim-mini/mini.surround",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            custom_surroundings = nil,
            highlight_duration = 300,
            mappings = {
                add = "sa", -- Add surrounding in Normal and Visual modes
                delete = "sd", -- Delete surrounding
                find = "sf", -- Find surrounding (to the right)
                find_left = "sF", -- Find surrounding (to the left)
                highlight = "sh", -- Highlight surrounding
                replace = "sr", -- Replace surrounding
                update_n_lines = "sn", -- Update `n_lines`

                suffix_last = "l", -- Suffix to search with "prev" method
                suffix_next = "n", -- Suffix to search with "next" method
            },
            n_lines = 20,
            respect_selection_type = false,
            search_method = "cover",
            silent = false,
        },
    },
    --indent blankline
    {
        "nvim-mini/mini.indentscope",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            symbol = "▏",
            options = { try_as_border = true },
        },
    },
    --commenting
    {
        "echasnovski/mini.comment",
        event = { "BufReadPre", "BufNewFile" },
        version = false,
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                event = "BufReadPost",
            },
        },
        config = function()
            -- disable the autocommand from ts-context-commentstring
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })

            require("mini.comment").setup({
                -- tsx, jsx, html , svelte comment support
                options = {
                    custom_commentstring = function()
                        return require("ts_context_commentstring.internal").calculate_commentstring({
                            key = "commentstring",
                        }) or vim.bo.commentstring
                    end,
                },
            })
        end,
    },
}
