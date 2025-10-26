return {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "v0.11.0",
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

        enabled = function()
            local blacklist_ft = {
                "TelescopePrompt",
                "NvimTree",
                "lazy",
                "mason",
                "alpha",
                "toggleterm",
                -- *** ADDING CORE FILE EXPLORER FILETYPES ***
                "neo-tree",
                "dirbuf",
                -- *** ADDING DRESSING/DIALOG RELATED FILETYPES ***
                "DressingInput",
                "DressingSelect",
            }
            local bufnr = vim.api.nvim_get_current_buf()
            local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

            for _, ft in ipairs(blacklist_ft) do
                if ft == filetype then
                    return false
                end
            end

            return true
        end,

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
            default = { "lsp", "lazydev", "snippets", "path", "buffer" },
            providers = {
                lsp = { score_offset = 1000 },
                lazydev = { module = "lazydev.integrations.blink", score_offset = 700 },
                snippets = { score_offset = 500 },
                path = { score_offset = 250 },
                buffer = { score_offset = 100 },
            },
        },

        snippets = { preset = "luasnip" },

        fuzzy = {
            implementation = "lua",
        },

        signature = { enabled = true },
    },
}
