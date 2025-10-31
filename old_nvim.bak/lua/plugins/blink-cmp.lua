return {
    "saghen/blink.cmp",
    enabled = false,
    event = "VimEnte",
    -- version = "v0.11.0",
    version = "1.*",
    -- build = "cargo +nightly build --release",
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
            accept = {
                auto_brackets = { enabled = true },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
            },
            -- ghost_text = { enabled = false },
            ghost_text = { enabled = vim.g.ai_cmp or false },
            trigger = {
                show_on_insert_on_trigger_character = false,
                show_on_keyword = true,
            },
            menu = {
                enabled = true,
            },
        },

        cmdline = {
            keymap = {
                ["<Tab>"] = { "accept" },
                ["<c-j>"] = { "select_next", "fallback" },
                ["<c-k>"] = { "select_prev", "fallback" },
                ["<C-space>"] = { "show", "cancel", "fallback" },
            },
            completion = { menu = { auto_show = true } },
        },

        keymap = {
            preset = "default",
            ["<C-y>"] = { "select_and_accept", "fallback" }, -- works in this Blink version
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<Tab>"] = { "snippet_forward", "select_and_accept", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
            ["<CR>"] = { "select_and_accept", "fallback" },
            ["<C-space>"] = { "show", "cancel", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                lsp = {
                    opts = { tailwind_color_icon = "󱓻" },
                    score_offset = 1000,
                },
                path = { score_offset = 250 },
                snippets = { score_offset = 500 },
                buffer = { score_offset = -3 },
            },
            per_filetype = {
                vim = { inherit_defaults = true, "cmdline" },
            },
        },

        snippets = {
            preset = "luasnip",
            score_offset = -3,
        },

        fuzzy = {
            -- implementation = "lua",
            -- implementation = "prefer_rust_with_warning",
            implementation = "prefer_rust",
        },

        signature = { enabled = true },
    },
}
