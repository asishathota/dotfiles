if vim.g.neovide then
    require("config.neovide")
    vim.cmd("cd ~")
end

if vim.env.VSCODE then
    vim.g.vscode = true
end

if vim.loader then
    vim.loader.enable()
end

require("config.lazy")
require("config.config")
-- require("config.statusline")
