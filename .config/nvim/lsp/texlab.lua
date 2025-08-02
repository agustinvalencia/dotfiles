-- In ~/.config/nvim/lsp/texlab.lua

local core_lsp = require("core.lsp")

return {
  cmd = { "texlab" },
  filetypes = { "tex", "bib", "plaintex", "latex" },
  on_attach = core_lsp.on_attach,
  capabilities = core_lsp.capabilities,
  settings = {
    texlab = {
      build = {
        engine = "tectonic",
        onSave = true,
        args = { "--synctex" },
      },
      format = {
        onSave = true,
      },
      forwardSearch = {
        command = "/usr/bin/open",
        args = { "-a", "Skim", "-g", "%p", "-c", "displayline %l %f" },
      },
    },
  },
}
