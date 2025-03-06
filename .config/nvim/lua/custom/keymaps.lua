-- example use:
-- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
local map = function(keys, func, desc, mode)
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { desc = desc })
end

if not vim.g.vscode then
  --
  -- ==========================================================
  --
  --                   VANILLA NEOVIM
  --
  -- ==========================================================
  --

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

  -- --------------------- (UI start) ---------------------
  -- Splits
  vim.keymap.set('n', '<leader>ush', '<cmd>split<CR>', { desc = '[U]I [H]orizontal [S]plit' })
  vim.keymap.set('n', '<leader>usv', '<cmd>vsplit<CR>', { desc = '[U]I [V]ertical [S]plit' })
  -- SMART-SPLITS
  -- Keybindings for navigation
  vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
  vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
  vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
  vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

  -- Keybindings for resizing
  vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
  vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
  vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
  vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
  -- --------------------- (UI end) ---------------------

  -- ---------------------
  -- YAZI : files navigation
  vim.keymap.set('n', '<leader>wf', '<cmd>Yazi<cr>', { desc = '[W]orkspace [F]ile Explorer' })
  -- ---------------------

  -- --------------------- (harpoon start) ---------------------
  -- HARPOON
  -- fast management of marks
  local harpoon = require 'harpoon'

  -- stylua: ignore start
  vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = '[H]arpoon [A]dd' })
  vim.keymap.set('n', '<leader>hu', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = '[H]arpoon [U]I' })
  vim.keymap.set('n', '<leader>ha', function() harpoon:list():select(1) end, { desc = '[H]arpoon go to [1]' })
  vim.keymap.set('n', '<leader>hs', function() harpoon:list():select(2) end, { desc = '[H]arpoon go to [2]' })
  vim.keymap.set('n', '<leader>hd', function() harpoon:list():select(3) end, { desc = '[H]arpoon go to [3]' })
  vim.keymap.set('n', '<leader>hf', function() harpoon:list():select(4) end, { desc = '[H]arpoon go to [4]' })
  vim.keymap.set('n', '<leader>hg', function() harpoon:list():select(4) end, { desc = '[H]arpoon go to [5]' })
  vim.keymap.set('n', '<leader>hh', function() harpoon:list():prev() end, { desc = '[H]arpoon go to previous' })
  vim.keymap.set('n', '<leader>hl', function() harpoon:list():next() end, { desc = '[H]arpoon go to next' })
  -- stylua: ignore end
  -- --------------------- (harpoon end) ---------------------

  -- Aerial
  -- shows code symbols in a separate pane
  vim.keymap.set('n', '<leader>cs', '<cmd>AerialToggle!<cr>', { desc = '[C]ode [S]ymbols' })

  --Custom diagnostics
  vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = '[D]iagnostics [F]ull' })
else
  --
  --
  --
  -- ==========================================================
  --
  --                   FOR VSCODE AS FRONTEND
  --
  -- ==========================================================
  --

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- remap leader key
  keymap('n', '<Space>', '', opts)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- better indent handling
  keymap('v', '<', '<gv', opts)
  keymap('v', '>', '>gv', opts)

  -- move text up and down
  keymap('v', 'J', ':m .+1<CR>==', opts)
  keymap('v', 'K', ':m .-2<CR>==', opts)
  keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
  keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)

  -- paste preserves primal yanked piece
  keymap('v', 'p', '"_dP', opts)

  -- removes highlighting after escaping vim search
  keymap('n', '<Esc>', '<Esc>:noh<CR>', opts)
  -- call vscode commands from neovim

  -- general keymaps
  -- stylua: ignore start
  keymap({ 'n', 'v' }, '<leader>t', "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
  keymap({ 'n', 'v' }, '<leader>b', "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
  keymap({ 'n', 'v' }, '<leader>d', "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
  keymap({ 'n', 'v' }, '<leader>a', "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
  keymap({ 'n', 'v' }, '<leader>sp', "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
  keymap({ 'n', 'v' }, '<leader>cn', "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
  keymap({ 'n', 'v' }, '<leader>ff', "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
  keymap({ 'n', 'v' }, '<leader>cp', "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
  keymap({ 'n', 'v' }, '<leader>pr', "<cmd>lua require('vscode').action('code-runner.run')<CR>")
  keymap({ 'n', 'v' }, '<leader>fd', "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
  -- stylua: ignore end
end
