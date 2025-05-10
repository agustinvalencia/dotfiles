-- treesitter.lua
return {
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "python", "javascript", "typescript", "tsx" },
          highlight        = { enable = true },
        })
      end,
    },
  }