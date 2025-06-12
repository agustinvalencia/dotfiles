-- lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  -- enabled = false,
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim",       opts = {} },
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local caps = require("cmp_nvim_lsp").default_capabilities()
    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    end

    -- python
    -- lspconfig.pyright.setup({ capabilities = caps, on_attach = on_attach })

    -- typescript
    lspconfig.ts_ls.setup({ capabilities = caps, on_attach = on_attach })
  end,
}
