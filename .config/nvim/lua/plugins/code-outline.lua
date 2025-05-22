return {
  "stevearc/aerial.nvim",

  opts = {
    default_direction = "right",
    placement = "edge",
  },
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>co", "<cmd>AerialToggle!<CR>", desc = "[C]ode [O]utline Toggle" },
  },
}
