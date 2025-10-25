return{
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Load Telescope and its actions
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local keymap = vim.keymap  -- for conciseness

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fgs", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

    keymap.set("n", "<leader>fc", function()
      builtin.find_files({
        cwd = "~/.config", -- limit search to the config directory
        prompt_title = "Search Config Files",
      })
    end, { desc = "Search Config Files" })

    keymap.set("n", "<leader>fg", function()
      builtin.git_files({
        prompt_title = "Search Git Files",
      })
    end, { desc = "Search Git Files" })

    keymap.set("n", "<leader>fs", function()
      builtin.live_grep({
        prompt_title = "Grep String",
      })
    end, { desc = "Live Grep" })

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
