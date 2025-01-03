if vim.g.vscode then
  return {}
end

return {
  'MeanderingProgrammer/render-markdown.nvim',
  enabled = true,
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  opts = {
    render_modes = { 'n', 'c', 'i' },
    heading = {
      width = { 'full', 'block', 'block', 'block' },
      left_pad = 0,
      right_pad = 0,
      border = true,
      border_prefix = false,
      min_width = 80,
    },
    indent = {
      enabled = false,
      per_level = 4,
    },
    checkbox = {
      unchecked = { icon = '󰄱 ' },
      checked = { icon = ' ' },
    },
    bullet = {
      left_pad = 1,
      right_pad = 1,
    },
    quote = { repeat_linebreak = true },
    latex = {
      enabled = true,
      converter = 'latex2text',
      highlight = 'RenderMarkdownMath',
      top_pad = 0,
      bottom_pad = 0,
    },
    link = {
      custom = {
        python = { pattern = '%.py$', icon = '󰌠 ', highlight = 'RenderMarkdownLink' },
      },
    },
    sign = { enabled = true },
    pipe_table = { preset = 'round' },
    win_options = {
      showbreak = { default = '', rendered = '  ' },
      breakindent = { default = false, rendered = true },
      breakindentopt = { default = '', rendered = '' },
    },
  },
}
