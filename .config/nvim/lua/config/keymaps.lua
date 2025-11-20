-- change normal motion to also work on wrapped lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Navigate between panes using Ctrl+h/j/k/l
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Navigate to column 100 (useful for long-form text in markdown/latex/typst
vim.api.nvim_set_keymap("n", "<leader>uc", "101|", { desc = "Go to column 101" })
-- vim.api.nvim_set_keymap("n", "<leader>uc", "100|", { desc = "Go to column 100" })

-- editor buffer split
vim.keymap.set("n", "<leader>u-", "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>u/", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

local wk = require("which-key")

-- terminal split
local create_terminal = function(orient)
  if orient == "h" then
    arg = "J"
  elseif orient == "v" then
    arg = "L"
  else
    print("Unknown orientation")
    return
  end
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd(arg)
end

-- easy close
local close_other_buffers = function()
  local bufs = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, i in ipairs(bufs) do
    if i ~= current_buf then
      vim.api.nvim_buf_delete(i, {})
    end
  end
end

-- stylua: ignore start
wk.add({
  -- First level containers
  { "<leader>l", group = "LaTeX", desc = "LaTeX" },
  { "<leader>g", group = "Git", desc = "Git" },
  { "<leader>c", group = "Code", desc = "Code" },
  { "<leader>u", group = "UI", desc = "UI" },
  { "<leader>f", group = "Find", desc = "Find" },
  { "<leader>s", group = "Search", desc = "Search" },
  { "<leader>m", group = "Markview", desc = "Markview" },

  -- Quick close
  { "<leader>w", "<cmd>w<cr>", desc = "Save" },
  { "<leader>W", "<cmd>wa<cr>", desc = "Save All" },
  { "<leader>q", "<cmd>q<cr>", desc = "Quit" },
  { "<leader>Q", "<cmd>qa<cr>", desc = "Quit All" },
  { "<leader>x", "<cmd>x<cr>", desc = "Save and Quit" },
  { "<leader>X", "<cmd>xa<cr>", desc = "Save All and Quit" },

  -- Buffers
  { "<leader>b", group = "Buffer", desc = "Buffer" },
  { "<leader>bb", "<C-6>", desc = "Back" },
  { "<leader>bD", function () close_other_buffers() end, desc = "[B]uffer [D]elete All BUT this one" },

  -- Terminal
  { "<leader>t", group = "Terminal", desc = "Terminal" },
  { "<leader>tv", function() create_terminal("v") end, desc = "Create Vertical Terminal", },
  { "<leader>th", function() create_terminal("h") end, desc = "Create Horizontal Terminal", },
})
-- stylua: ignore end
