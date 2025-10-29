-- lua/plugins/lspconfig.lua

return {
  -- LSP Configuration & Server Management
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Installer for LSPs, formatters, etc.
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry on build
        opts = {
          ensure_installed = {
            -- LSPs
            "pyright",
            "rust_analyzer",
            "tsserver",
            "lua_ls",
            -- Linters / Formatters
            "ruff",
            "stylua",
            "shellcheck",
          },
        },
      },
      -- The "glue" plugin between mason and lspconfig
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      -- This function defines the on_attach and capabilities handlers.
      -- These will be passed to each server individually by mason-lspconfig.

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true, noremap = true }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configure mason-lspconfig to use our handlers
      require("mason-lspconfig").setup({
        handlers = {
          -- The default handler will attach to all servers and pass our settings
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
          -- Moving python lsps to the new native settings
          -- Gradually I will leave lspconfig plugin
          ["pyright"] = function() end,
          ["ruff_lsp"] = function() end,
          -- You can add custom setups for specific servers here
          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                  workspace = { checkThirdParty = false },
                },
              },
            })
          end,
        },
      })
    end,
  },

  -- none-ls (for formatters and linters)
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.diagnostics.ruff,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.shellcheck,
        },
      }
    end,
  },
}
-- return {}
