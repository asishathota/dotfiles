return {
    "zbirenbaum/copilot.lua",
    enabled = false,
    opts = function(_, opts)
        -- override LazyVim defaults
        opts.suggestion.enabled = false
        opts.suggestion.auto_trigger = false
        opts.panel.enabled = false
        return opts
    end,
    keys = {
        {
            "<leader>co",
            function()
                vim.cmd("Copilot toggle")
            end,
            desc = "Toggle Copilot",
        },
    },
}
