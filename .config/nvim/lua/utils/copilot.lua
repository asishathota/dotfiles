local M = {}

M.toggle_copilot = function()
    -- Check if Copilot is currently disabled according to the plugin's status
    if require("copilot.client").is_disabled() then
        require("copilot.command").enable()
        vim.notify("Copilot Enabled", vim.log.levels.INFO)
        -- Set a global variable to indicate it should be enabled next session
        vim.g.copilot_enabled_on_startup = true
    else
        require("copilot.command").disable()
        vim.notify("Copilot Disabled", vim.log.levels.INFO)
        -- Set a global variable to indicate it should be disabled next session
        vim.g.copilot_enabled_on_startup = false
    end
end

return M
