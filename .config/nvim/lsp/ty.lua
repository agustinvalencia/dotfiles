local core_lsp = require("core.lsp")
return {
  on_attach = core_lsp.on_attach,
  capabilities = core_lsp.capabilities,
  filetypes = { "python" },
  root_markers = { ".git", "pyproject.toml", "requirements.txt", ".venv" },
}
