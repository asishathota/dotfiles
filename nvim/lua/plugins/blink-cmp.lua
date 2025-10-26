return {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    build = "cargo build --release",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "2.*",
            build = (function()
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            },
            opts = {},
        },
        "folke/lazydev.nvim",
    },
    opts = {
        keymap = {
            preset = "default",
            ["<C-y>"] = { "select_and_accept", "fallback" }, -- works in this Blink version
            ["<Tab>"] = { "snippet_forward", "select_and_accept", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<CR>"] = { "select_and_accept", "fallback" },
            ["<C-space>"] = { "show", "cancel", "fallback" },
        },

        appearance = {
            nerd_font_variant = "mono",
        },

        completion = {
            accept = { auto_brackets = { enabled = true } },
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
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
            default = { "lsp", "path", "snippets", "lazydev" },
            providers = {
                lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
            },
        },

        snippets = { preset = "luasnip" },

        fuzzy = { implementation = "lua" },

        signature = { enabled = true },
    },
}
