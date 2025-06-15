-- mason-null-ls.lua
return {
    enabled=false,
  'jayp0521/mason-null-ls.nvim',
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    require('mason-null-ls').setup {
      ensure_installed = { 'ruff', 'pyright' },
      automatic_installation = true,
    }
  end,
}
