return {
  {
    "GCBallesteros/jupytext.nvim",
    config = true,
  },
  {
    "GCBallesteros/NotebookNavigator.nvim",
    event = "VeryLazy",
    dependencies = {
      "echasnovski/mini.comment",
      "hkupty/iron.nvim", -- repl provider
      "anuvyklack/hydra.nvim",
    },
    config = {},
    keys = {
      -- stylua: ignore start
      { "<leader>cd", function() require("notebook-navigator").move_cell("d") end, },
      { "<leader>cu", function() require("notebook-navigator").move_cell("u") end, },
      { "<leader>cX", function() require('notebook-navigator').run_cell() end, desc = "Run cell" },
      { "<leader>cx", function() require('notebook-navigator').run_and_move() end, desc = "Run cell and move" },
      -- stylua: ignore end
    },
  },
}
