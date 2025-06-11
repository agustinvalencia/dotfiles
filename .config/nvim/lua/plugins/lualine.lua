if vim.g.vscode then
  return {}
end

local function custom_lua_line()
  return {
    options = {
      -- theme = bubbles_theme,
      theme = "catppuccin",
      component_separators = "|",
      section_separators = { left = "", right = "" },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        { "mode", separator = { left = "" }, right_padding = 1 },
      },
      -- lualine_b = { 'branch', 'diagnostics', 'searchcount', 'selectioncount' },
      lualine_b = {
        { "branch" },
      },
      lualine_c = {
        {
          function()
            return "Buffers: " .. #vim.fn.getbufinfo({ buflisted = 1 })
          end,
          icon = " ", -- Icon to represent buffers
        },
      },
      lualine_x = { },
      lualine_y = { "filetype" },
      lualine_z = {
        {
          "filename",
          separator = { right = "" },
          left_padding = 1,
          path = 1, -- 1: Relative path
          shorting_target = 40, -- Shortens the path if it's longer than 40 characters
          symbols = {
            modified = " ", -- Text to show when the buffer is modified
            readonly = " ", -- Text to show when the buffer is read-only
            unnamed = "[No Name]", -- Text to show for unnamed buffers
          },
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }
end

return {
  -- the opts function can also be used to change the default opts:
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   event = 'VeryLazy',
  -- },
  --
  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return custom_lua_line()
    end,
  },
}
