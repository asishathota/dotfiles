-- local opt = vim.opt
--
-- opt.number = true
-- opt.relativenumber = true
-- opt.mouse = ""
-- opt.cursorline = false
--
-- -- tabs & indentation
-- opt.tabstop = 4 -- 4 spaces for tabs
-- opt.shiftwidth = 4 -- 4 spaces for indent width
-- opt.expandtab = true -- expand tab to spaces
-- opt.autoindent = true -- copy indent from current line when starting a new one
-- opt.smartindent = true -- insert indents automatically
--
-- -- wrapping
-- opt.wrap = false -- disable line wrapping
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldenable = false
--
-- -- session settings
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
--
-- -- search settings
-- opt.ignorecase = true -- ignore case when searching
-- opt.smartcase = true -- use case-sensitive search if uppercase letters are present
-- -- opt.signcolumn = "no"
-- -- opt.signcolumn = "auto:1"
-- opt.signcolumn = "yes"
--
-- -- colors and ui
-- opt.termguicolors = true -- enable true color support
-- opt.background = "dark" -- use dark background for colorschemes
-- opt.winborder = "rounded"
--
-- -- backspace
-- opt.backspace = "indent,eol,start" -- allow backspace over indent, eol, and insert mode start
--
-- -- clipboard
-- opt.clipboard = "unnamedplus"
-- if not vim.g.neovide then
--     vim.g.clipboard = {
--         name = "xclip",
--         copy = {
--             ["+"] = "xclip -selection clipboard",
--             ["*"] = "xclip -selection primary",
--         },
--         paste = {
--             ["+"] = "xclip -selection clipboard -o",
--             ["*"] = "xclip -selection primary -o",
--         },
--         cache_enabled = 1,
--     }
--     -- vim.g.loaded_clipboard_provider = 1
-- end
--
-- -- split window behavior
-- opt.splitright = true -- vertical splits open to the right
-- opt.splitbelow = true -- horizontal splits open below
--
-- -- disable swapfile
-- opt.swapfile = false -- turn off swapfile
--
-- -- undo and backzp
-- opt.undofile = true -- enable persistent undo
-- opt.undolevels = 5000 -- maximum undo levels
--
-- -- folding
-- opt.foldmethod = "indent" -- use indentation for folding
-- opt.foldlevel = 99 -- open all folds by default
--
-- -- scrolling and context
-- opt.scrolloff = 10 -- lines of context around the cursor
-- opt.sidescrolloff = 10 -- columns of context for horizontal scrolling
--
-- -- miscellaneous
-- opt.autowrite = true -- enable auto write
-- opt.splitright = true -- vertical splits to the right
-- opt.showmode = true
-- opt.cmdheight = 0
-- opt.laststatus = 3
-- opt.path:append({ "**" })
-- opt.wildignore:append({ "*/node_modules/*" })
-- opt.fillchars = "vert:│,horiz:─,eob: ,fold: "
--
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 1
-- vim.g.netrw_winsize = 25
-- vim.g.netrw_liststyle = 3

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = false
opt.wrap = false
opt.signcolumn = "yes"
opt.termguicolors = true
opt.background = "dark"
opt.showcmd = false
opt.showmode = false
opt.cmdheight = 0
opt.laststatus = 0
opt.pumblend = 10
opt.pumheight = 10
opt.smoothscroll = true
opt.spelllang = { "en" }
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.statuscolumn = ""

opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    vert = "│",
    horiz = "─",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

-- Mouse
opt.mouse = ""

-- Tabs / Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.completeopt = "menu,menuone,noselect"

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Files / Backup / Undo
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 5000
vim.scriptencoding = "utf-8"
opt.fileencoding = "utf-8"
opt.encoding = "utf-8"
opt.backspace = "indent,eol,start"
opt.clipboard = "unnamedplus"

if not vim.g.neovide then
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
end

-- Window / Splits
opt.splitright = true
opt.splitbelow = true
opt.inccommand = "nosplit"
opt.breakindent = true
opt.linebreak = true
opt.scrolloff = 10
opt.sidescrolloff = 10

-- Folding
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldtext = ""
opt.formatexpr = "v:lua.LazyVim.format.formatexpr()"
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Session
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Paths / Ignore
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })

-- Netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3

-- Autowrite
opt.autowrite = true

-- Markdown
vim.g.markdown_recommended_style = 0
