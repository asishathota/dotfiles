return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local noice = require("noice")
        local notify = require("notify")

        noice.setup({
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                    ["vim.lsp.buf.signature_help"] = true,
                },
                signature = { enabled = false },
                hover = { enabled = true },
            },
            routes = {
                {
                    filter = { event = "msg_show", kind = "search_count" },
                    opts = { skip = true }, -- This would skip search count messages
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = false,
                inc_rename = false,
                lsp_doc_border = true,
            },
            vim.keymap.set("n", "<leader>hn", "<CMD>Noice dismiss<CR>"),
        })

        notify.setup({
            background_colour = "#00000000",

            max_width = function()
                return math.floor(vim.o.columns * 0.7) -- up to 90% of screen width
            end,
            max_height = function()
                return math.floor(vim.o.lines * 0.7) -- up to 90% of screen height
            end,

            timeout = 5000,
            fps = 60,
            render = "wrapped-compact",

            stages = "static",
            -- stages = "fade_in_slide_out",
            merge_duplicates = false,

            top_down = true, -- newer messages appear on top
            level = "info",

            on_open = function(win)
                vim.api.nvim_win_set_config(win, { focusable = false })
            end,
            on_close = function()
                vim.cmd("redraw!") -- refresh UI after closing
            end,
        })

        vim.notify = notify
    end,
}
