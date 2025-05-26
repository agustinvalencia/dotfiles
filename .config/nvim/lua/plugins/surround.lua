return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  version = "^3.0.0",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
