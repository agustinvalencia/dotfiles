local core_lsp = require("core.lsp")
return {
  on_attach = core_lsp.on_attach,
  capabilities = core_lsp.capabilities,
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { ".git", "pyproject.toml", "requirements.txt", ".venv" },
  settings = {
    python = {
      analysis = {
        extraPaths = { "./src" },
        exclude = { "**/node_modules", "**/__pycache__", ".venv/**", "env/**", "venv/**" },
        typeCheckingMode = "strict",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {
          reportUnusedImport = "warning",
          reportOptionalMemberAccess = "none",
        },
      },
    },
  },
}
