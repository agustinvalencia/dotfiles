-- none-ls.lua

return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jay-babu/mason-null-ls.nvim",
    -- 'jayp0521/mason-null-ls',
  },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({

      sources = {
        require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
        require("none-ls.formatting.ruff_format"),
        null_ls.builtins.formatting.prettier.with({ filetypes = { "json", "yaml", "markdown", "javascript", "typescript", "tsx" } }),
      },

      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = "LspFormatting",
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end,
    })
  end,
}
