if vim.g.vscode then
  return {}
end
-- changes line background color depending on active vim mode
return {
  {
    'mvllow/modes.nvim',
    tag = 'v0.2.0',
    config = function()
      require('modes').setup()
    end,
  },
}
