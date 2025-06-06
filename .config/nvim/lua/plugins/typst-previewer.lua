return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  keys = {

    { "<leader>cp", "<cmd>TypstPreview<CR>", desc = "[C]ode Typst [P]review" },
  },
}
