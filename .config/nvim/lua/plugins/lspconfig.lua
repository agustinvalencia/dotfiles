-- lspconfig.lua
return {
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
      },
      config = function()
        local lspconfig = require("lspconfig")
        local caps = require("cmp_nvim_lsp").default_capabilities()
        local on_attach = function(_, bufnr)
          local opts = { noremap=true, silent=true, buffer=bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K",  vim.lsp.buf.hover,      opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        end
  
        lspconfig.pyright.setup({ capabilities=caps, on_attach=on_attach })
        lspconfig.ts_ls.setup({ capabilities=caps, on_attach=on_attach })
      end,
    },
  }