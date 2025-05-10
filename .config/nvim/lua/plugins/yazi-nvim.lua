return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>-', '<cmd>Yazi<CR>', desc = 'Open Yazi at current file' },
    { '<leader>cw', '<cmd>Yazi cwd<CR>', desc = 'Open file manager in cwd' },
    { '<c-k>', '<cmd>Yazi toggle<CR>', desc = 'Resume last Yazi session' },
  },
  opts = {
    open_for_directories = true,
    -- additional configuration for split columns and keybindings…
  },
}
