return {
  "iamcco/markdown-preview.nvim",
    enabled=false,
  build = "cd app && npm install",
  ft = "markdown",
  config = function()
    vim.fn["mkdp#util#install"]()
  end,
}
