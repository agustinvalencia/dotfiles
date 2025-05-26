return {
  "folke/twilight.nvim",
  opts = {
    dimming = {
      alpha = 0.5,
    },
    context = 20,
    treesitter = true,
  },
  keys = {
    { "<leader>uf", "<cmd>Twilight<CR>", desc = "[U]I [F]ocus Code" },
  },
}
