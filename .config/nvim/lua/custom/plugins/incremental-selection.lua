if vim.g.vscode then
  return {}
end
return {
  'sustech-data/wildfire.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('wildfire').setup()
  end,
}
