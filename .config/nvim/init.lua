-- init.lua

if vim.env.VSCODE then
  vim.g.vscode = true
end

require("config.options")
require("core.lazy")
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
  "ltex",
  "clangd",
})

require("config.keymaps")
require("config.autocmds")
require("commands")
