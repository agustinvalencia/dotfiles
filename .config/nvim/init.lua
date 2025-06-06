if vim.env.VSCODE then
  vim.g.vscode = true
end

require("config.options")
require("core.lazy")
require("core.lsp")
require("config.keymaps")
require("config.autocmds")
