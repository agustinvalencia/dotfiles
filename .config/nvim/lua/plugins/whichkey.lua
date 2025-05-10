-- whichkey.lua
return {
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      config = function()
        local wk = require("which-key")
        wk.setup()  -- use defaults
        wk.register({
          r = {
            name = "Refactor",
            n = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename Symbol" },
          },
        }, { prefix = "<leader>" })
      end,
    },
  }