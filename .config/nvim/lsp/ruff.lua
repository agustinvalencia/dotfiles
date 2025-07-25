-- ~/.config/nvim/lsp/ruff.lua

-- local core_lsp = require("core.lsp")
--
-- -- Create a custom capabilities table for ruff by copying the default one
-- local ruff_capabilities = vim.deepcopy(core_lsp.capabilities)
-- -- Disable the definition provider for ruff
-- ruff_capabilities.textDocument.definition = false
--
return {
  cmd = { "uvx ruff server --preview" },
  filetypes = { "python" },
  -- Use the shared on_attach function for keymaps
  -- on_attach = core_lsp.on_attach,
  -- Use the custom capabilities table
  -- capabilities = ruff_capabilities,

  init_options = {
    settings = {
      lineLength = 100,
      fixAll = true,
      configuration = {
        format = {
          ["quote-style"] = "single",
        },
      },
    },
  },
}
