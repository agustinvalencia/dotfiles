-- lua/core/lsp.lua
-- Core LSP settings: on_attach, diagnostics, keymaps, and native server bootstrap for Neovim 0.11+

local M = {}

-- Shared on_attach: keymaps, format-on-save, rename, etc.
function M.on_attach(client, bufnr)
  -- Base options for keymaps
  local base_opts = { noremap = true, silent = true, buffer = bufnr }

  -- Workspace-wide rename
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", base_opts, { desc = "[C]ode [R]ename symbol (LSP)" }))

  -- Go to definition
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", base_opts, { desc = "[G]o to [D]efinition (LSP)" }))

  -- Hover documentation
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", base_opts, { desc = "Hover documentation (LSP)" }))

  -- Format buffer
  vim.keymap.set("n", "<leader>cf", function()
    vim.lsp.buf.format({ bufnr = bufnr, async = true })
  end, vim.tbl_extend("force", base_opts, { desc = "[C]ode [F]ormat buffer (LSP)" }))

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

-- Setup on_attach for any server via LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client then
      M.on_attach(client, ev.buf)
    end
  end,
})

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

-- Bootstrap native LSP servers by name
-- Call this from init.lua with a list of server names
function M.enable_servers(server_list)
  for _, name in ipairs(server_list) do
    vim.lsp.enable(name)
  end
end

return M
