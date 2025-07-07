-- ~/.config/nvim/lsp/pyright.lua
return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { ".git", "pyproject.toml", "requirements.txt", ".venv" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        exclude = { "**/node_modules", "**/__pycache__", ".venv/**", "env/**", "venv/**" },
        extraPaths = { "./src" },
        diagnosticSeverityOverrides = {
          reportUnusedImport = "warning",
          reportOptionalMemberAccess = "none",
        },
      },
    },
  },
}
