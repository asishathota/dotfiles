return {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",

    opts = {
        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
        },

        completion = {
            accept = { auto_brackets = { enabled = true } },
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
            ghost_text = { enabled = vim.g.ai_cmp or false },
            trigger = {
                show_on_insert_on_trigger_character = false,
                show_on_keyword = true,
            },
            menu = {
                enabled = true,
            },
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        keymap = {
            preset = "default",
            ["<C-y>"] = { "select_and_accept", "fallback" }, -- works in this Blink version
            ["<Tab>"] = { "snippet_forward", "select_and_accept", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<CR>"] = { "select_and_accept", "fallback" },
            ["<C-space>"] = { "show", "fallback" },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },

    opts_extend = { "sources.default" },
}
