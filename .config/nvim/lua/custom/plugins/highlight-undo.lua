if vim.g.vscode then
  return {}
end
return {
  enabled = false,
  'tzachar/highlight-undo.nvim',
  event = 'VeryLazy',
  opts = {},
}
