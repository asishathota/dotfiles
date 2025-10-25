return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lua",
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        require("luasnip.loaders.from_vscode").lazy_load()
        vim.opt.completeopt = { "menu", "menuone", "noselect" }

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            preselect = "item",

            completion = {
                completeopt = "menu,menuone,noinsert",
            },

            window = {
                documentation = cmp.config.window.bordered(),
                completion = {
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                    winhighlight = "Normal:CmpCompletion,FloatBorder:CmpBorder",
                },
            },

            sources = {
                -- { name = "nvim_lsp" },
                -- { name = "luasnip" },
                -- { name = "buffer" },
                -- { name = "path" },
                -- { name = "nvim_lsp", priority = 1000, group_index = 1, keyword_length = 2, max_item_count = 10 },
                -- { name = "luasnip", priority = 750, group_index = 1, keyword_length = 2, max_item_count = 10 },
                -- { name = "buffer", priority = 500, group_index = 2, keyword_length = 1, max_item_count = 10 },
                -- { name = "path", priority = 250, group_index = 2, keyword_length = 1, max_item_count = 5 },
                { name = "nvim_lsp", priority = 1000, group_index = 1, keyword_length = 2, max_item_count = 15 },
                { name = "luasnip", priority = 750, group_index = 1, keyword_length = 2, max_item_count = 10 },
                {
                    name = "buffer",
                    priority = 500,
                    group_index = 2,
                    keyword_length = 1,
                    max_item_count = 10,
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
                { name = "path", priority = 250, group_index = 2, keyword_length = 1, max_item_count = 5 },
            },

            formatting = {
                fields = { "abbr", "menu", "kind" },
                format = function(entry, item)
                    local n = entry.source.name

                    -- local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })

                    -- if n == "nvim_lsp" then
                    --     item.menu = "[LSP]"
                    -- else
                    --     item.menu = string.format("[%s]", n)
                    -- end
                    -- return lspkind.cmp_format({
                    --     maxwidth = 50,
                    --     ellipsis_char = "...",
                    -- })(entry, item)

                    local source_icon = {
                        nvim_lsp = "λ",
                        luasnip = "⋗",
                        buffer = "",
                        path = "🖫",
                    }

                    item.menu = source_icon[n] or "[?]"
                    item.kind = lspkind.presets.default[item.kind] or item.kind
                    return item
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end),

                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),

                ["<CR>"] = cmp.mapping.confirm({ select = true }),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            experimental = {
                ghost_text = true,
            },
        })
    end,
}
