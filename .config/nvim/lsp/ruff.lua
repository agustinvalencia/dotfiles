-- ~/.config/nvim/lsp/ruff.lua

local core_lsp = require("core.lsp")

return {
  cmd = { "ruff server --preview" },
  filetypes = { "python" },
  on_attach = core_lsp.on_attach,
  capabilities = core_lsp.capabilities,
  settings = {
    typeChecking = { enabled = true },
    fixAll = true,
    lineLength = 100,
  },
}
