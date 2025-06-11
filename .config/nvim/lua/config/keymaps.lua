-- change normal motion to also work on wrapped lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Navigate between panes using Ctrl+h/j/k/l
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- editor buffer split
vim.keymap.set("n", "<leader>u-", "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>u/", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

-- terminal split
-- copied from TJ's advent of neovim in youtube
vim.keymap.set("n", "<leader>tv", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("L")
end, { desc = "[T]erminal [V]ertical" })

vim.keymap.set("n", "<leader>th", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)
end, { desc = "[T]erminal [H]orizontal" })

-- easy close
vim.keymap.set({ "n", "t" }, "<leader>qq", "<cmd>q<cr>", { desc = "[Q]uick [Q]uit" })
vim.keymap.set({ "n", "t" }, "<leader>xx", "<cmd>xa!<cr>", { desc = "[Q]uick save and quit [X]" })

vim.keymap.set("n", "<leader>op", "<cmd>OpenPdf<cr>", { desc = "[O]pen [P]df" })
vim.keymap.set("n", "<leader>bD", function()
  local bufs = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, i in ipairs(bufs) do
    if i ~= current_buf then
      vim.api.nvim_buf_delete(i, {})
    end
  end
end, { desc = "[B]uffer [D]elete All BUT this one" })
