if vim.g.neovide then
    require("asish.config.neovide")
    vim.cmd("cd ~")
end

if vim.env.VSCODE then
    if vim.g.vscode then
    end
end

if vim.loader then
    vim.loader.enable()
end

require("asish.config")
