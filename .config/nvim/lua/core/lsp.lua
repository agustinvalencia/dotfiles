-- lua/core/lsp.lua
-- Core LSP settings: on_attach, diagnostics, keymaps, and native server bootstrap for Neovim 0.11+

local M = {}

-- Shared on_attach: keymaps, format-on-save, rename, etc.
function M.on_attach(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
  end
  map("n", "gD", vim.lsp.buf.declaration, "LSP: Declaration")
  map("n", "gd", vim.lsp.buf.definition, "LSP: Definition")
  map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
  map("n", "gi", vim.lsp.buf.implementation, "LSP: Implementation")
  map("n", "<space>rn", vim.lsp.buf.rename, "LSP: Rename")
  map("n", "<space>ca", vim.lsp.buf.code_action, "LSP: Code Action")
  map("n", "gr", vim.lsp.buf.references, "LSP: References")

  if client.supports_method("textDocument/formatting") then
    local grp = vim.api.nvim_create_augroup("LspFormat_" .. client.name, {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = grp,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  -- RUST
  if client.name == "rust_analyzer" then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
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

-- Capabilities (integrate with nvim-cmp if present)
local ok, cmp = pcall(require, "cmp_nvim_lsp")
M.capabilities = ok and cmp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

return M
