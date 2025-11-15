return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        modes = {
            char = {
                enabled = false,
            },
            search = {
                enabled = false,
            },
            treesitter = {
                enabled = false,
            },
            remote = {
                enabled = true,
            },
        },
    },
    keys = {
        {
            "gs",
            mode = { "o", "n", "x" },
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
        },
    },
}
