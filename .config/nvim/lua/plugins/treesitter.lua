-- treesitter.lua
return {
  { "fei6409/log-highlight.nvim", event = "BufRead *.log", opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "tsx",
          "bash",
          "json",
          "yaml",
          "regex",
          "python",
          "javascript",
          "typescript",
          "toml",
          "css",
          "rust",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
