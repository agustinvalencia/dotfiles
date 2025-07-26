local C = require("catppuccin.palettes").get_palette()
local devicons = require("nvim-web-devicons")
return {
  "b0o/incline.nvim",
  config = function()
    require("incline").setup({
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local modified = vim.bo[props.buf].modified
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        return {
          ft_icon and { " ", ft_icon, " ", guibg = C.blue, guifg = C.base },
          filename,
          modified and { "   ", guifg = C.maroon, gui = "bold" } or "",
          " ",
          guibg = C.blue,
          guifg = C.base,
        }
      end,
    })
  end,
  -- Optional: Lazy load Incline
  event = "VeryLazy",
}
