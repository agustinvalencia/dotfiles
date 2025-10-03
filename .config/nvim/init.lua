-- init.lua

if vim.env.VSCODE then
  vim.g.vscode = true
end

require("config.options")
require("core.lazy")

-- Ensure core LSP hooks are defined
require("core.lsp")

-- Enable each server by its filename
vim.lsp.enable({
  "lua_ls",
  "ruff",
  -- "ty",
  "pyright",
  "tinymist",
  "rust_analyzer",
  "texlab",
})

require("config.keymaps")
require("config.autocmds")
require("config.wrapping")
require("commands")
