--  ~/.config/nvim/lsp/ty.lua

return {
  cmd = { "ty server" },
  filetypes = { "python" },
  root_markers = { ".git", "pyproject.toml", "requirements.txt", ".venv" },
}
