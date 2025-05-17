return {
  'GCBallesteros/NotebookNavigator.nvim',
  enabled = false,
  keys = {
    { '<leader>pm', "<cmd>lua require('notebook-navigator').run_and_move()<cr>", '[P]ython run cell and [M]ove' },
    { '<leader>pr', "<cmd>lua require('notebook-navigator').run_cell()<cr>", '[Python] [R]un cell' },
  },
  dependencies = {
    'echasnovski/mini.comment',
    'hkupty/iron.nvim', -- repl provider
    'anuvyklack/hydra.nvim',
  },
  event = 'VeryLazy',
  config = function()
    local nn = require 'notebook-navigator'
    nn.setup { activate_hydra_keys = '<leader>h' }
  end,
}
