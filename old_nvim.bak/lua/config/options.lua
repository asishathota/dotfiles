local opt = vim.opt

-- line numbering
opt.number = true
opt.relativenumber = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new one
opt.smartindent = true -- insert indents automatically

-- wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- use case-sensitive search if uppercase letters are present

-- colors and ui
opt.termguicolors = true -- enable true color support
opt.background = "dark" -- use dark background for colorschemes
opt.signcolumn = "yes" -- always show the sign column to prevent text shifting

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace over indent, eol, and insert mode start

-- clipboard
opt.clipboard = "unnamedplus" -- sync with system clipboard

-- split window behavior
opt.splitright = true -- vertical splits open to the right
opt.splitbelow = true -- horizontal splits open below

-- disable swapfile
opt.swapfile = false -- turn off swapfile

-- undo and backup
opt.undofile = true -- enable persistent undo
opt.undolevels = 10000 -- maximum undo levels

-- folding
opt.foldmethod = "indent" -- use indentation for folding
opt.foldlevel = 99 -- open all folds by default

-- scrolling and context
opt.scrolloff = 4 -- lines of context around the cursor
opt.sidescrolloff = 8 -- columns of context for horizontal scrolling

-- miscellaneous
opt.autowrite = true -- enable auto write
opt.splitright = true -- vertical splits to the right
