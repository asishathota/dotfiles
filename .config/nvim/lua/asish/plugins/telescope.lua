return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- Load Telescope and its actions
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                    ".git/",
                    "venv/",
                    ".venv/",
                    "__pycache__/",
                    "dist/",
                    "build/",
                },
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<esc>"] = require("telescope.actions").close,
                        ["<leader>"] = require("telescope.actions").close,
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        local keymap = vim.keymap

        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fu", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

        keymap.set("n", "<leader>fc", function()
            builtin.find_files({
                cwd = vim.fn.stdpath("config"),
            })
        end, { desc = "Goto config" })

        keymap.set("n", "<leader>fa", function()
            builtin.find_files({
                cwd = "~/.config",
                prompt_title = "Search Config Files",
            })
        end, { desc = "Search Config Files" })

        keymap.set("n", "<leader>fg", function()
            builtin.git_files({
                prompt_title = "Search Git Files",
            })
        end, { desc = "Search Git Files" })

        keymap.set("n", "<leader>gc", function()
            builtin.git_commits({
                prompt_title = "Git Commits",
            })
        end, { desc = "Git Commits" })

        keymap.set("n", "<leader>gs", function()
            builtin.git_status({
                prompt_title = "Git Status",
            })
        end, { desc = "Git Status" })
    end,
}
