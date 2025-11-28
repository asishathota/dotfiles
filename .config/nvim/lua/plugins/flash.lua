return {
    "folke/flash.nvim",
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
                enabled = false,
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
        {
            "<c-space>",
            mode = { "n", "o", "x" },
            function()
                require("flash").treesitter({
                    actions = {
                        ["<c-space>"] = "next",
                        ["<BS>"] = "prev",
                    },
                })
            end,
            desc = "Treesitter Incremental Selection",
        },
    },
}
