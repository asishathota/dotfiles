if vim.g.neovide then
    require("config.neovide")
    vim.cmd("cd ~")
end

if vim.env.VSCODE then
end

if vim.loader then
    vim.loader.enable()
end

require("config.lazy")
-- require("config.statusline")
