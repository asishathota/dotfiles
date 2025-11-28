return {
    "christoomey/vim-tmux-navigator",
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
    },
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {},
    },
    {
        "vimpostor/vim-tpipeline",
        enabled = function()
            return vim.env.TMUX ~= nil
        end,
        event = "VimEnter",
    },
    {
        "MagicDuck/grug-far.nvim",
        opts = { headerMaxWidth = 80 },
        cmd = { "GrugFar", "GrugFarWithin" },
        keys = {
            {
                "<leader>fr",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "x" },
                desc = "Search and Replace",
            },
        },
    },
}
