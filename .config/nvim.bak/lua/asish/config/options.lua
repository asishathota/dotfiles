local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = ""
opt.cursorline = false

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new one
opt.smartindent = true -- insert indents automatically

-- wrapping
opt.wrap = false -- disable line wrapping

-- session settings
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- use case-sensitive search if uppercase letters are present
-- opt.signcolumn = "no"
-- opt.signcolumn = "auto:1"
opt.signcolumn = "yes"

-- colors and ui
opt.termguicolors = true -- enable true color support
opt.background = "dark" -- use dark background for colorschemes
opt.winborder = "rounded"

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace over indent, eol, and insert mode start

-- clipboard
opt.clipboard = "unnamedplus"
vim.g.clipboard = {
    name = "xclip",
    copy = {
        ["+"] = "xclip -selection clipboard",
        ["*"] = "xclip -selection primary",
    },
    paste = {
        ["+"] = "xclip -selection clipboard -o",
        ["*"] = "xclip -selection primary -o",
    },
    cache_enabled = 1,
}
-- vim.g.loaded_clipboard_provider = 1

-- split window behavior
opt.splitright = true -- vertical splits open to the right
opt.splitbelow = true -- horizontal splits open below

-- disable swapfile
opt.swapfile = false -- turn off swapfile

-- undo and backzp
opt.undofile = true -- enable persistent undo
opt.undolevels = 5000 -- maximum undo levels

-- folding
opt.foldmethod = "indent" -- use indentation for folding
opt.foldlevel = 99 -- open all folds by default

-- scrolling and context
opt.scrolloff = 10 -- lines of context around the cursor
opt.sidescrolloff = 10 -- columns of context for horizontal scrolling

-- miscellaneous
opt.autowrite = true -- enable auto write
opt.splitright = true -- vertical splits to the right
opt.showmode = true
opt.cmdheight = 1
opt.laststatus = 3
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })
opt.fillchars = "vert:│,horiz:─,eob: ,fold: "

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3

-- vim.api.nvim_create_autocmd("TextYankPost", {
--     desc = "Highlight when yanking (copying) text",
--     group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
--     callback = function()
--         vim.hl.on_yank()
--     end,
-- })

--==========================--
--====statusline====--
--==========================--

function _G.full_mode()
    local map = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        V = "V-LINE",
        ["\22"] = "V-BLOCK",
        c = "COMMAND",
        R = "REPLACE",
        t = "TERMINAL",
    }
    return map[vim.api.nvim_get_mode().mode] or "?"
end

function _G.smart_path()
    local path = vim.fn.expand("%:~:.")
    if #path > 40 then
        path = "…" .. path:sub(-40)
    end
    return path
end

function _G.lsp_diagnostics()
    local d = vim.diagnostic
    local e = #d.get(0, { severity = d.severity.ERROR })
    local w = #d.get(0, { severity = d.severity.WARN })
    local h = #d.get(0, { severity = d.severity.HINT })
    local i = #d.get(0, { severity = d.severity.INFO })

    local res = {}
    if e > 0 then
        table.insert(res, " " .. e)
    end
    if w > 0 then
        table.insert(res, " " .. w)
    end
    if h > 0 then
        table.insert(res, " " .. h)
    end
    if i > 0 then
        table.insert(res, " " .. i)
    end
    return table.concat(res, " ")
end

function _G.macro_recording()
    local rec = vim.fn.reg_recording()
    if rec == "" then
        return ""
    end
    return "recording @" .. rec
end

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
    callback = function()
        vim.schedule(function()
            vim.cmd("redrawstatus")
        end)
    end,
})

vim.o.statusline = table.concat({
    " %{v:lua.full_mode()} ",
    " %<%{v:lua.smart_path()}%m%r ",
    " %{v:lua.lsp_diagnostics()} ",
    " %{v:lua.macro_recording()} ",
    " %= ",
    " %3p%%  %l:%c ",
    " %{strftime(' %H:%M')} ",
})
