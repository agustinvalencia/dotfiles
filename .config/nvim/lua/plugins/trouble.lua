return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      symbols = {
        format = "{kind_icon}{symbol.name:Normal}",
      },
    },
  },
  cmd = "Trouble",
  keys = {
    {
      "<leader>cd",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics",
    },
    {
      "<leader>cD",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle win.position=right<cr>",
      desc = "Symbols",
    },
    -- {
    --   "<leader>cl",
    --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    --   desc = "LSP Definitions / references / ...",
    -- },
    {
      "<leader>cr",
      "<cmd>Trouble lsp_references toggle focus=true<cr>",
      desc = "LSP references",
    },
    {
      "<leader>ci",
      "<cmd>Trouble lsp_incoming_calls toggle focus=true win.position=bottom<cr>",
      desc = "LSP Incoming Calls",
    },
    {
      "<leader>co",
      "<cmd>Trouble lsp_outgoing_calls toggle focus=true win.position=bottom<cr>",
      desc = "LSP Outgoing Calls",
    },
    {
      "<leader>cL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>cQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
