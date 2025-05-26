-- editor buffer split
vim.keymap.set("n", "<leader>u-", "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>u\\", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

-- terminal split
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
