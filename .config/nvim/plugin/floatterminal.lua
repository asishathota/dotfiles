vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n><CMD>q<CR>")

local state = {
    floating = {
        buf = -1,
        win = -1,
    },
    job_id = nil,
}

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)
    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window({ buf = state.floating.buf })

        -- Create terminal only if buffer is not terminal yet
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd("terminal")
            state.job_id = vim.b.terminal_job_id
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

-- 🔥 Kill job automatically when Neovim closes
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        if state.job_id then
            vim.fn.jobstop(state.job_id)
        end
    end,
})

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<leader>m", ":Floaterminal<CR>", { noremap = true, silent = true })
