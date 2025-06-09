return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  opts = {
    follow_cursor = true,
    open_cmd = "open %s",
  },
  keys = {
    { "<leader>cp", "<cmd>TypstPreview<CR>", desc = "[C]ode Typst [P]review" },
  },
}
