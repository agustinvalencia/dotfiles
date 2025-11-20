-- lua/plugins/mason.lua
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- LSP servers / tools you want available on PATH
        "rust_analyzer",
        "pyright",
        "lua_ls",
        "ruff",
        "stylua",
        "shellcheck",
      },
    },
  },
  { "j-hui/fidget.nvim", opts = {} }, -- optional LSP status
  {
    "nvimtools/none-ls.nvim", -- optional: formatters/linters
    dependencies = { "williamboman/mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.diagnostics.ruff,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.shellcheck,
        },
      }
    end,
  },
}
