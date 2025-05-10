-- none-ls.lua
return {
    {
      "nvimtools/none-ls.nvim",
      dependencies = { "jay-babu/mason-null-ls.nvim" },
      config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
          sources = {
            null_ls.builtins.diagnostics.ruff,
            -- null_ls.builtins.formatting.ruff.with({ extra_args = { "--fix" } }),
            null_ls.builtins.formatting.prettier,
          },
          on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
              vim.api.nvim_clear_autocmds({ group="LspFormatting", buffer=bufnr })
              vim.api.nvim_create_augroup("LspFormatting", {})
              vim.api.nvim_create_autocmd("BufWritePre", {
                group    = "LspFormatting",
                buffer   = bufnr,
                callback = function() vim.lsp.buf.format() end,
              })
            end
          end,
        })
      end,
    },
  }