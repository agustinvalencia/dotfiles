-- example use:
-- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
local map = function(keys, func, desc, mode)
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { desc = desc })
end


  -- motion keys to handle wrapped lines
  map('j', 'gj', 'move down', 'n')
  map('k', 'gk', 'move up', 'n')

  -- --------------------- (Buffer management start) ---------------------
  -- Quit all
  map('<leader>Q', '<cmd>qa<cr>', '[Q]uit Neovim', 'n')
  map('<leader>X', '<cmd>xa<cr>', '[X]ave and quit Neovim', 'n')

  -- Quit current buffer
  map('qq', '<cmd>q<cr>', '[Quit] current buffer')

  -- Fast move to previous buffer
  vim.keymap.set('n', '<leader><leader>', '<C-^>', { desc = 'Switch to previous buffer' })

  -- --------------------- (Buffer management end) ---------------------
  
  -- YAZI : files navigation
  vim.keymap.set('n', '<leader>wf', '<cmd>Yazi<cr>', { desc = '[W]orkspace [F]ile Explorer' })

  -- Aerial
  -- shows code symbols in a separate pane
  vim.keymap.set('n', '<leader>cs', '<cmd>AerialToggle!<cr>', { desc = '[C]ode [S]ymbols' })

  --Custom diagnostics
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = '[D]iagnostics [F]ull' })

