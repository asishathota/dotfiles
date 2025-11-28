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
