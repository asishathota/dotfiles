return {
    "saghen/blink.cmp",
    build = "cargo build --release",
    opts_extend = {
        "sources.completion.enabled_providers",
        "sources.compat",
        "sources.default",
    },
    dependencies = {
        "rafamadriz/friendly-snippets",
        -- { "L3MON4D3/LuaSnip", version = "v2.*" },
        "onsails/lspkind.nvim",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
        snippets = {
            preset = "default",
        },

        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
        },

        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
            menu = {
                border = "rounded",
                draw = {
                    treesitter = { "lsp" },
                },
            },
            documentation = {
                auto_show = true,
                treesitter_highlighting = true,
                window = { border = "rounded" },
            },
            ghost_text = {
                -- enabled = vim.g.ai_cmp,
                enabled = true,
            },
            list = { selection = { preselect = true } },
        },

        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lsp = {
                    min_keyword_length = 0,
                    score_offset = 0, -- Boost/penalize the score of the items
                },
                path = {
                    min_keyword_length = 0,
                },
                snippets = {
                    min_keyword_length = 2,
                    max_items = 5,
                },
                buffer = {
                    min_keyword_length = 5,
                    max_items = 5,
                },
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },

        signature = {
            enabled = true,
        },

        cmdline = {
            enabled = true,
            keymap = {
                preset = "cmdline",
                ["<Right>"] = false,
                ["<Left>"] = false,
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },
            },
            completion = {
                list = { selection = { preselect = false } },
                menu = {
                    auto_show = function(ctx)
                        return vim.fn.getcmdtype() == ":"
                    end,
                },
                ghost_text = { enabled = true },
            },
        },

        keymap = {
            preset = "enter",

            ["<C-y>"] = { "select_and_accept" },

            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },

            ["<C-space>"] = {
                function()
                    require("blink-cmp").show()
                end,
                "hide",
            },

            ["<Tab>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_and_accept()
                    end
                end,
                "snippet_forward",
                "fallback",
            },
            ["<S-Tab>"] = {
                function(cmp)
                    return cmp.select_prev()
                end,
                "snippet_backward",
                "fallback",
            },

            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },
    },
    config = function(_, opts)
        -- local snippet_path = vim.fn.stdpath("config") .. "/snippets"
        -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippet_path } })
        require("blink.cmp").setup(opts)
    end,
}
