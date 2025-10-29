-- clangd server config for Neovim 0.11 native LSP.
-- The file name ('clangd.lua') is also the server name used by vim.lsp.enable().
local core_lsp = require("core.lsp")

return {
  cmd = { "clangd" }, -- language server binary
  filetypes = { "c", "cpp", "objc", "objcpp" }, -- buffers to attach
  root_markers = { "CMakeLists.txt", ".git" }, -- project root detection
  on_attach = core_lsp.on_attach, -- shared keymaps & hooks
  capabilities = core_lsp.capabilities, -- completion, etc.
  -- settings = {}, -- (optional) clangd settings
}
