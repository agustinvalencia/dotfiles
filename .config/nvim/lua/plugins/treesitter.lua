-- treesitter.lua
return {
  { "fei6409/log-highlight.nvim", event = "BufRead *.log", opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufnewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- lua/vim
          "lua",
          "vim",
          "vimdoc",
          -- scripting
          "bash",
          "query",
          "regex",
          -- data layer
          "json",
          "yaml",
          "toml",
          -- python
          "python",
          -- webdev
          "tsx",
          "javascript",
          "typescript",
          "css",
          -- rust
          "rust",
        },
        modules = {},
        ignore_install = {},
        sync_install = true,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
