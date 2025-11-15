return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({
            auto_restore_enabled = false,
            auto_session_suppress_dirs = { "/home/ashu/", "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
        })
        vim.keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
        vim.keymap.set(
            "n",
            "<leader>ws",
            "<cmd>AutoSession save<CR>",
            { desc = "Save session for auto session root dir" }
        )
        vim.keymap.set("n", "<leader>wf", "<cmd>AutoSession search<CR>", { desc = "Search sessions" })
        vim.keymap.set("n", "<leader>wd", "<cmd>AutoSession delete<CR>", { desc = "Delete sessions" })
    end,
}
