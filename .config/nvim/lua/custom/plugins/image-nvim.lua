if vim.g.vscode then
  return {}
end

return {
  '3rd/image.nvim',
  event = 'VeryLazy',
  ft = { 'markdown' },
  dependencies = {
    { 'leafo/magick', lazy = true },
    { 'nvim-treesitter/nvim-treesitter', lazy = true },
  },
  opts = {
    backend = 'kitty',
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    tmux_show_only_in_active_window = true,
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { 'markdown' }, -- markdown extensions (ie. quarto) can go here
      },
      neorg = { enabled = false },
      html = { enabled = false },
      css = { enabled = false },
    },
  },
}
