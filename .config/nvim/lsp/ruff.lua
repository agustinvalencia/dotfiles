-- ~/.config/nvim/lsp/ruff.lua

local core_lsp = require("core.lsp")

return {
  cmd = { "uvx ruff server --preview" },
  filetypes = { "python" },
  on_attach = core_lsp.on_attach,
  capabilities = core_lsp.capabilities,
  settings = {
    typeChecking = { enabled = true },
    fixAll = true,
    format = {
      ["quote-style"] = "single",
    },
    lineLength = 100,
  },
}
