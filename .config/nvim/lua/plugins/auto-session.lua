return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({
            auto_restore_enabled = false,
            auto_session_suppress_dirs = {
                "/home/ashu/",
                "~/",
                "~/Dev/",
                "~/Downloads",
                "~/Documents",
                "~/Desktop/",
            },
        })
    end,
    keys = {
        { "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" } },
        { "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" } },
        { "<leader>wf", "<cmd>AutoSession search<CR>", { desc = "Search sessions" } },
        { "<leader>wd", "<cmd>AutoSession delete<CR>", { desc = "Delete sessions" } },
    },
}
