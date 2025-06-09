-- change normal motion to also work on wrapped lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

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

-- easy close
vim.keymap.set({ "n", "t" }, "<leader>qq", "<cmd>q<cr>", { desc = "[Q]uick [Q]uit" })
vim.keymap.set({ "n", "t" }, "<leader>xx", "<cmd>xa!<cr>", { desc = "[Q]uick save and quit [X]" })

vim.keymap.set("n", "<leader>op", "<cmd>OpenPdf<cr>", { desc = "[O]pen [P]df" })
