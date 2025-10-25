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
opt.showmode = false
opt.cmdheight = 1
opt.laststatus = 2


----------------custom status-line------------------


local cmp = {} -- statusline components

--- highlight pattern
-- This has three parts: 
-- 1. the highlight group
-- 2. text content
-- 3. special sequence to restore highlight: %*
-- Example pattern: %#SomeHighlight#some-text%*
local hi_pattern = '%%#%s#%s%%*'

function _G._statusline_component(name)
  return cmp[name]()
end

function cmp.diagnostic_status()
  local ok = ' λ '

  local ignore = {
    ['c'] = true, -- command mode
    ['t'] = true  -- terminal mode
  }

  local mode = vim.api.nvim_get_mode().mode

  if ignore[mode] then
    return ok
  end

  local levels = vim.diagnostic.severity
  local errors = #vim.diagnostic.get(0, {severity = levels.ERROR})
  if errors > 0 then
    return ' ✘ '
  end

  local warnings = #vim.diagnostic.get(0, {severity = levels.WARN})
  if warnings > 0 then
    return ' ▲ '
  end

  return ok
end

function cmp.position()
  return hi_pattern:format('Search',' %3l:%-2c ')
end

local statusline = {
  '%{%v:lua._statusline_component("diagnostic_status")%} ',
  '%t',
  '%r',
  '%m',
  '%=',
  '%{&filetype} ',
  ' %2p%% ',
  '%{%v:lua._statusline_component("position")%}'
}

vim.o.statusline = table.concat(statusline, '')
