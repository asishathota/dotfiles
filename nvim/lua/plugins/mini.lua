return {
    {
        "nvim-mini/mini.ai",
        version = "*",
        config = function()
            require("mini.ai").setup({})
        end,
    },
    {
        "nvim-mini/mini.surround",
        version = "*",
        config = function()
            require("mini.surround").setup({})
        end,
    },
    {
        "nvim-mini/mini.pairs",
        config = function()
            require("mini.pairs").setup({
                modes = { insert = true, command = false, terminal = false },

                mappings = {
                    ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
                    ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
                    ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

                    [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
                    ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
                    ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

                    ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
                    ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
                    ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
                },
            })
        end,
    },
    -- {
    --     "nvim-mini/mini.indentscope",
    --     version = false, -- wait till new 0.7.0 release to put it back on semver
    --     opts = {
    --         symbol = "▏",
    --         -- symbol = "│",
    --         options = { try_as_border = true },
    --     },
    --     init = function()
    --         vim.api.nvim_create_autocmd("FileType", {
    --             pattern = {
    --                 "Trouble",
    --                 "alpha",
    --                 "dashboard",
    --                 "fzf",
    --                 "help",
    --                 "lazy",
    --                 "mason",
    --                 "neo-tree",
    --                 "notify",
    --                 "sidekick_terminal",
    --                 "snacks_dashboard",
    --                 "snacks_notif",
    --                 "snacks_terminal",
    --                 "snacks_win",
    --                 "toggleterm",
    --                 "trouble",
    --             },
    --             callback = function()
    --                 vim.b.miniindentscope_disable = true
    --             end,
    --         })
    --
    --         vim.api.nvim_create_autocmd("User", {
    --             pattern = "SnacksDashboardOpened",
    --             callback = function(data)
    --                 vim.b[data.buf].miniindentscope_disable = true
    --             end,
    --         })
    --     end,
    -- },
}
