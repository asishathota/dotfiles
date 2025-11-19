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
        event = "InsertEnter",
        opts = {},
    },
    {
        "vimpostor/vim-tpipeline",
        event = "VimEnter",
    },
}
