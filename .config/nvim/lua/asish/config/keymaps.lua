local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<C-S-v>", "<C-v>", { desc = "Enter into V-Block mode" })

keymap.set("n", "<leader>ee", "<CMD>Oil<CR>")
keymap.set("n", "-", "<CMD>Oil<CR>")

if vim.g.neovide then
    keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })
    keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true })
end

-- keymap.set("n", "<leader>ct", "<CMD>Copilot toggle<CR>", { desc = "Toggle Copilot" })

keymap.set("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
end, { desc = "Toggle Inlay Hints" })

keymap.set("n", "<leader>ll", "<cmd>Lazy<CR>")
keymap.set("n", "<leader>lp", "<cmd>Lazy profile<CR>")
keymap.set("n", "<leader>lr", "<cmd>restart<CR>")

keymap.set("v", "<Tab>", ">gv", { desc = "Indent visual selection right" })
keymap.set("v", "<S-Tab>", "<gv", { desc = "Indent visual selection left" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=v", { desc = "Make splits equal size" })
keymap.set("n", "<leader>so", "<C-w>v<cmd>Telescope find_files<cr>", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

keymap.set({ "i", "n" }, "<A-z>", "<cmd>set wrap!<CR>", { desc = "toggle wrap text" })

keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase Window Width" })

keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

keymap.set("n", "<leader>sm", function()
    if vim.t.maximized then
        vim.cmd("wincmd =")
        vim.t.maximized = false
    else
        vim.cmd("wincmd _")
        vim.cmd("wincmd |")
        vim.t.maximized = true
    end
end, { desc = "Toggle Maximize Split" })

local diagnostic_goto = function(next, severity)
    return function()
        vim.diagnostic.jump({
            count = next and 1 or -1,
            severity = severity and vim.diagnostic.severity[severity] or nil,
        })
    end
end

keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
