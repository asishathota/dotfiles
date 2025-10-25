local function enable_transparency()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

  vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
end

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
   vim.cmd([[colorscheme tokyonight-night]])
   enable_transparency()
  end,
}
