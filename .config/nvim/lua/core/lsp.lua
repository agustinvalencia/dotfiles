-- lua/core/lsp.lua
-- Core LSP settings: on_attach, diagnostics, keymaps, and native server bootstrap for Neovim 0.11+

local M = {}

-- Shared on_attach: keymaps, format-on-save, rename, etc.
function M.on_attach(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  -- See `:help vim.lsp.*` for more information on the functions below.
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

  -- This enables inlay hints for Rust.
  -- can toggle them with a keymap if needed later.
  if client.name == "rust_analyzer" then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- Auto-format on save if supported
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat_" .. client.name, {}),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

-- Diagnostic UI settings
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M
