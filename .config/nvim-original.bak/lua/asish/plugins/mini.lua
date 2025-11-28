return {
    {
        "nvim-mini/mini.pairs",
        event = "VimEnter",
        opts = {
            modes = { insert = true, command = false, terminal = false },
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            skip_ts = { "string" },
            skip_unbalanced = true,
            markdown = true,
        },
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
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

    -- indent blankline
    {
        "nvim-mini/mini.indentscope",
        enabled = not vim.g.vscode,
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {
            symbol = "▏",
            options = { try_as_border = true },
        },
    },

    --commenting
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                lazy = true,
                opts = {
                    enable_autocmd = false,
                },
            },
        },
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                        or vim.bo.commentstring
                end,
            },
        },
        -- config = function()
        --     -- disable the autocommand from ts-context-commentstring
        --     require("ts_context_commentstring").setup({
        --         enable_autocmd = false,
        --     })
        --
        --     local allowed_ft = {
        --         javascript = true,
        --         javascriptreact = true,
        --         typescript = true,
        --         typescriptreact = true,
        --         html = true,
        --         svelte = true,
        --         vue = true,
        --     }
        --
        --     require("mini.comment").setup({
        --         -- tsx, jsx, html , svelte comment support
        --         options = {
        --             custom_commentstring = function()
        --                 return require("ts_context_commentstring.internal").calculate_commentstring({
        --                     key = "commentstring",
        --                 }) or vim.bo.commentstring
        --             end,
        --         },
        --     })
        -- end,
    },
}
