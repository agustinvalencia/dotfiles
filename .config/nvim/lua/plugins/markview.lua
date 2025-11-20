return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  config = function()
    require("markview").setup({
      latex = { enable = false },
      typst = { enable = false },
    })
  end,
  keys = {
    { "<leader>mt", "<cmd>Markview toggle<cr>", desc = "Markview Toggle" },
  },
}
