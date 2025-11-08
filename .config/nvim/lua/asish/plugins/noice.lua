return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
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
                filter = {
                    event = "notify",
                    find = "No information available",
                },
            },
            -- cmdline = {
            -- 	view = "cmdline",
            -- },
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
            timeout = 5000,
            max_width = 80,
            render = "wrapped-compact",
            stages = "fade",
            merge_duplicates = false,
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { focusable = false })
            end,
        })

        vim.notify = notify
    end,
}
