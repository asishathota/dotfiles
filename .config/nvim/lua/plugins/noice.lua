return {
    "folke/noice.nvim",
    opts = function(_, opts)
        opts.lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
                ["vim.lsp.buf.signature_help"] = true,
            },
            signature = { enabled = false },
            hover = { enabled = true },
        }
        opts.routes = {
            {
                filter = { event = "msg_show", kind = "search_count" },
                opts = { skip = true },
            },
        }
        opts.presets = {
            bottom_search = false,
            command_palette = true,
            long_message_to_split = false,
            inc_rename = false,
            lsp_doc_border = true,
        }
    end,
    keys = {
        { "<leader>hn", "<CMD>NoiceDismiss<CR>", { desc = "Dismiss all notifications" } },
    },
}
