if vim.g.vscode then
  return {}
end
return {
  'akinsho/bufferline.nvim',
  version = '*', -- Use the latest stable version
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers', -- Show buffers
        numbers = 'none', -- Hide buffer numbers
        close_command = 'bdelete! %d', -- Command to close buffers
        right_mouse_command = 'bdelete! %d', -- Close buffer with right-click
        left_mouse_command = 'buffer %d', -- Open buffer with left-click
        middle_mouse_command = nil, -- No action on middle-click
        indicator = {
          style = 'none', -- Hide the indicator
        },
        buffer_close_icon = '',
        modified_icon = '',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        show_buffer_icons = false, -- Disable icons for file types
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        separator_style = { '▁▁', '▁▁' }, -- Use thicker separators
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        diagnostics = false, -- Disable diagnostics
        max_name_length = 0, -- Set to 0 to avoid truncation
        offsets = {},

        custom_filter = function(buf_number)
          -- Only show the active buffer
          local current_buf = vim.fn.bufnr '%'
          return buf_number == current_buf
        end,

        custom_areas = {
          right = function()
            local total_buffers = #vim.fn.getbufinfo { buflisted = 1 }
            return {
              { text = ' Buffers: ' .. total_buffers .. ' ', guifg = '#ffffff' },
            }
          end,
        },
      },
      highlights = {
        fill = {
          guifg = '#ffffff',
          guibg = '#282c34',
          gui = 'bold',
        },
        background = {
          guifg = '#ffffff',
          guibg = '#3e4452',
        },
        separator = {
          guifg = '#282c34',
          guibg = '#282c34',
        },
        separator_selected = {
          guifg = '#282c34',
          guibg = '#282c34',
        },
      },
    }
  end,
}
