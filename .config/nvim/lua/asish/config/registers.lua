-- vim.fn.setreg("l", "yoconsole.log("^[pa :", ^[pa)^[")

-- server.log(process.env.HELLO)
-- console.log("process.env.HELLO :", process.env.HELLO)
--
--

local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)

vim.api.nvim_create_augroup("JSLogMacro", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = "JSLogMacro",
    pattern = { "javascript", "typescript" },
    callback = function()
        vim.fn.setreg("l", "yoconsole.log(' :', )" .. esc .. "hhhhhhplllllpo" .. esc .. "")
    end,
})
