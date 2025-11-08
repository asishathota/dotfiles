vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
    desc = "highlight selection on yank",
    callback = function()
        vim.highlight.on_yank({ timeout = 150, visual = true, higroup = "YankHighlight" })
    end,
})
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#696969", fg = "#FFFFFF" })

vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("no_auto_comment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
    pattern = { ".env", ".env.*" },
    callback = function()
        vim.bo.filetype = "dosini"
    end,
})

-- notify the macro reading
local recording_augroup = vim.api.nvim_create_augroup("MacroRecordingGroup", { clear = true })

vim.api.nvim_create_autocmd("RecordingEnter", {
    group = recording_augroup, -- Assign it to the group
    callback = function()
        local reg_name = vim.fn.reg_recording()
        if reg_name ~= "" then
            vim.notify("Macro Recording Started in register @" .. reg_name, vim.log.levels.INFO, { title = "Noice" })
        else
            vim.notify("Macro Recording Started!", vim.log.levels.INFO, { title = "Noice" })
        end
    end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    group = recording_augroup, -- Assign this one too
    callback = function()
        vim.notify("Macro Recording Stopped.", vim.log.levels.INFO, { title = "Noice" })
    end,
})
