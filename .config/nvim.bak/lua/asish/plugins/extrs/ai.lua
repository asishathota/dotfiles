return {
    {
        "zbirenbaum/copilot.lua",
        cmd = { "Copilot", "CopilotAuth", "CopilotSetup" },
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                -- disable panel/popups if you want only cmp items (optional)
                panel = { enabled = false },
                suggestion = {
                    enabled = false, -- disable the inline suggestion overlay (we use copilot-cmp)
                },
                -- filetypes = {
                --     -- enable for filetypes you want. By default all are enabled, but you can customize
                --     -- Example: disable for markdown
                --     markdown = false,
                -- },
            })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua", "nvim-cmp" },
        config = function()
            -- Use the "getCompletionsCycling" method or "getCompletions" (try both)
            require("copilot_cmp").setup({
                method = "getCompletionsCycling", -- recommended
            })
        end,
    },
}
