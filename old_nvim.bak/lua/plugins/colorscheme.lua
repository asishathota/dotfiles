-- tokyonight.lua
return {
  'folke/tokyonight.nvim',  -- The repository for the TokyoNight colorscheme
  priority = 1000,
  lazy = false,
  config = function()
    -- You can configure the colorscheme here
    vim.cmd[[colorscheme tokyonight-night]]  -- Set the colorscheme after installation
  end,
}
