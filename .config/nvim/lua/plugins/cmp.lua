-- cmp.lua
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- Load on entering insert mode for efficiency
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Source for LSP
      "hrsh7th/cmp-buffer", -- Source for buffer words
      "hrsh7th/cmp-path", -- Source for file paths
      "L3MON4D3/LuaSnip", -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        debug = true,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-k>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<tab>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
