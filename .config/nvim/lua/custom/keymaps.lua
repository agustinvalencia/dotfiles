if not vim.g.vscode then
  -- Oil
  -- files navigation
  vim.keymap.set('n', '<leader>wf', require('oil').open_float, { desc = '[W]orkspace [F]ile Explorer' })

  -- Harpoon
  -- fast management of marks
  local harpoon = require 'harpoon'

  vim.keymap.set('n', '<leader>ha', function()
    harpoon:list():add()
  end, { desc = '[H]arpoon [A]dd' })

  vim.keymap.set('n', '<leader>hu', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = '[H]arpoon [U]I' })

  vim.keymap.set('n', '<leader>h1', function()
    harpoon:list():select(1)
  end, { desc = '[H]arpoon go to [1]' })

  vim.keymap.set('n', '<leader>h2', function()
    harpoon:list():select(2)
  end, { desc = '[H]arpoon go to [2]' })

  vim.keymap.set('n', '<leader>h3', function()
    harpoon:list():select(3)
  end, { desc = '[H]arpoon go to [3]' })

  vim.keymap.set('n', '<leader>h4', function()
    harpoon:list():select(4)
  end, { desc = '[H]arpoon go to [4]' })

  vim.keymap.set('n', '<leader>hh', function()
    harpoon:list():prev()
  end, { desc = '[H]arpoon go to previous' })

  vim.keymap.set('n', '<leader>hl', function()
    harpoon:list():next()
  end, { desc = '[H]arpoon go to next' })

  -- Aerial
  -- shows code symbols in a separate pane
  vim.keymap.set('n', '<leader>cs', '<cmd>AerialToggle!<cr>', { desc = '[C]ode [S]ymbols' })

  -- Obsidian
  vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianToday<cr>', { desc = '[O]bsidian [T]oday' })
  vim.keymap.set('n', '<leader>on', '<cmd>ObsidianNewFromTemplate<cr>', { desc = '[O]bsidian [N]ew from Template' })

  --Custom diagnostics
  vim.keymap.set('n', '<leader>cdf', vim.diagnostic.open_float, { desc = '[C]ode [D]iagnostics [F]ull' })
else
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- remap leader key
  keymap('n', '<Space>', '', opts)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- yank to system clipboard
  -- keymap({ 'n', 'v' }, '<leader>y', '"+y', opts)

  -- paste from system clipboard
  -- keymap({ 'n', 'v' }, '<leader>p', '"+p', opts)

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

  -- harpoon keymaps
  -- keymap({ 'n', 'v' }, '<leader>ha', "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
  -- keymap({ 'n', 'v' }, '<leader>ho', "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
  -- keymap({ 'n', 'v' }, '<leader>he', "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
  -- keymap({ 'n', 'v' }, '<leader>h1', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
  -- keymap({ 'n', 'v' }, '<leader>h2', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
  -- keymap({ 'n', 'v' }, '<leader>h3', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
  -- keymap({ 'n', 'v' }, '<leader>h4', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
  -- keymap({ 'n', 'v' }, '<leader>h5', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
  -- keymap({ 'n', 'v' }, '<leader>h6', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
  -- keymap({ 'n', 'v' }, '<leader>h7', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
  -- keymap({ 'n', 'v' }, '<leader>h8', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
  -- keymap({ 'n', 'v' }, '<leader>h9', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")
end
