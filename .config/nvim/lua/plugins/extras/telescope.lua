return {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
        local actions = require("telescope.actions")

        opts.defaults.mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                ["<C-j>"] = actions.move_selection_next, -- move to next result
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<esc>"] = require("telescope.actions").close,
                ["<leader>"] = require("telescope.actions").close,
            },
        }

        -- opts.pickers = opts.pickers or {}
        -- opts.pickers.find_files = {
        --     find_command = {
        --         "fd",
        --         "--type",
        --         "f",
        --         "--color",
        --         "never",
        --         "--exclude",
        --         "node_modules",
        --         "--exclude",
        --         ".git",
        --         "--exclude",
        --         "dist",
        --         "--exclude",
        --         "build",
        --     },
        -- }
        --
        -- return opts
    end,
    keys = {
        { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
        { ";f", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" } },
        { ";s", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" } },
        { "<leader>fu", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" } },
        {
            ";c",
            function()
                require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
            end,
            { desc = "Goto config" },
        },
        {
            ";a",
            function()
                require("telescope.builtin").find_files({ cwd = "~/.config", prompt_title = "Search Config Files" })
            end,
            { desc = "Search Config Files" },
        },
    },
}
