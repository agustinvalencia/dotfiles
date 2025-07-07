-- init.lua

if vim.env.VSCODE then
  vim.g.vscode = true
end

require("config.options")
require("core.lazy")

-- Ensure core LSP hooks are defined
require("core.lsp")

-- Enable each server by its filename
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("rust_analyzer")

require("config.keymaps")
require("config.autocmds")
require("commands")
