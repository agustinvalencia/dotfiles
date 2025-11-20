-- lua/core/lsp.lua
-- Core LSP: capabilities, on_attach (keymaps, format-on-save, codelens/inlay-hints), diagnostics

local M = {}

-- Capabilities (use cmp_nvim_lsp if present; otherwise fall back to defaults)
do
  local ok, cmp = pcall(require, "cmp_nvim_lsp")
  M.capabilities = ok and cmp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
end

function M.on_attach(client, bufnr)
  -- purge any legacy chord that might still exist
  pcall(vim.keymap.del, "n", "<leader>ca", { buffer = bufnr })
  pcall(vim.keymap.del, "x", "<leader>ca", { buffer = bufnr })
  pcall(vim.keymap.del, "n", "<space>ca", { buffer = bufnr })
  pcall(vim.keymap.del, "x", "<space>ca", { buffer = bufnr })

  -- conflict-free LSP prefix; works in normal + visual/select; no-wait
  vim.keymap.set({ "n", "x" }, "<leader>la", function()
    vim.lsp.buf.code_action()
  end, { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = "LSP: Code Action" })

  -- (optional alias if you want the old chord too)
  -- vim.keymap.set({ "n", "x" }, "<leader>ca", function() vim.lsp.buf.code_action() end,
  --   { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = "LSP: Code Action (alias)" })
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
  end

  -- Navigation & info
  map("n", "gD", vim.lsp.buf.declaration, "LSP: Declaration")
  map("n", "gd", vim.lsp.buf.definition, "LSP: Definition")
  map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
  map("n", "gi", vim.lsp.buf.implementation, "LSP: Implementation")
  map("n", "gr", vim.lsp.buf.references, "LSP: References")

  -- Edits
  map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
  map("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, "LSP: Code Action")
  map("v", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, "LSP: Code Action (Range)")

  -- Format on save if supported
  if client.supports_method("textDocument/formatting") then
    local grp = vim.api.nvim_create_augroup("LspFormat_" .. client.name .. "_" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = grp,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  -- Rust extras
  if client.name == "rust_analyzer" then
    pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr }) -- Neovim 0.11 API

    -- CodeLens refresh (safe even if disabled in settings)
    local grp = vim.api.nvim_create_augroup("RustCodelens_" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      group = grp,
      buffer = bufnr,
      callback = function()
        pcall(vim.lsp.codelens.refresh)
      end,
    })
    map("n", "<leader>cl", function()
      vim.lsp.codelens.run()
    end, "LSP: Run CodeLens")
  end
end

-- Diagnostics UI
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

return M

--
--
--
--
--
--
--
-- lua/core/lsp.lua
-- Core LSP settings: on_attach, diagnostics, keymaps, and native server bootstrap for Neovim 0.11+

-- local M = {}
--
-- -- Shared on_attach: keymaps, format-on-save, rename, etc.
-- function M.on_attach(client, bufnr)
--   local map = function(mode, lhs, rhs, desc)
--     print(lhs)
--     vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
--   end
--   map("n", "gD", vim.lsp.buf.declaration, "LSP: Declaration")
--   map("n", "gd", vim.lsp.buf.definition, "LSP: Definition")
--   map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
--   map("n", "gi", vim.lsp.buf.implementation, "LSP: Implementation")
--   map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
--   map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
--   map("n", "gr", vim.lsp.buf.references, "LSP: References")
--
--   if client.supports_method("textDocument/formatting") then
--     local grp = vim.api.nvim_create_augroup("LspFormat_" .. client.name, {})
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       group = grp,
--       buffer = bufnr,
--       callback = function()
--         vim.lsp.buf.format({ bufnr = bufnr })
--       end,
--     })
--   end
--
--   -- RUST
--   if client.name == "rust_analyzer" then
--     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--   end
-- end
--
-- -- Diagnostic UI settings
-- vim.diagnostic.config({
--   underline = true,
--   update_in_insert = false,
--   severity_sort = true,
--   float = { border = "rounded", source = true },
--   signs = {
--     text = {
--       [vim.diagnostic.severity.ERROR] = " ",
--       [vim.diagnostic.severity.WARN] = " ",
--       [vim.diagnostic.severity.INFO] = " ",
--       [vim.diagnostic.severity.HINT] = " ",
--     },
--     numhl = {
--       [vim.diagnostic.severity.ERROR] = "ErrorMsg",
--       [vim.diagnostic.severity.WARN] = "WarningMsg",
--     },
--   },
-- })
--
-- -- Capabilities (integrate with nvim-cmp if present)
-- local ok, cmp = pcall(require, "cmp_nvim_lsp")
-- M.capabilities = ok and cmp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
--
-- return M
