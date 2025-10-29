return {

  "catppuccin/nvim",
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    vim.cmd.colorscheme("catppuccin-mocha")
    vim.cmd.hi("Comment gui=none")
    -- vim.cmd.hi("ColorColumn ctermbg=lightgrey guibg=lightgrey")
  end,

  config = function()
    require("catppuccin").setup({
      flavour = "macchiato",
      transparent_background = true,
      auto_integrations = true,
      float = {
        transparent = false, -- enable transparent floating windows
        solid = false, -- use solid styling for floating windows, see |winborder|
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = { "italic" },
        keywords = { "bold" },
        strings = { "italic" },
      },
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.95, -- percentage of the shade to apply to the inactive window
      },
      markdown = true,
      render_markdown = true,
      noice = true,
      which_key = true,
      default_integrations = true,
      custom_highlights = function(colors)
        return {
          ["ColorColumn"] = { bg = colors.overlay, fg = colors.red },
          -- ["ColorColumn"] = { bg = colors.flamingo, fg = colors.surface2 },
          -- NvimTreeNormal = { fg = colors.none },
          -- Comment = { fg = colors.flamingo },
          -- ["@keyword"] = { fg = colors.pink },
          -- ["@keyword.import"] = { fg = colors.pink },
          -- ["@type"] = { fg = colors.blue },
          -- ["@variable.parameter"] = { fg = colors.teal },
          ["@comment"] = { fg = colors.overlay2, style = { "italic" } },
          -- ["@text.literal"] = { fg = colors.yellow },
          -- ["@error"] = { fg = colors.red },
          -- ["@string"] = { fg = colors.yellow },
          ["@string.documentation"] = { fg = colors.subtext1, style = { "italic" } },
          -- ["@function"] = { fg = colors.pink, bold = true },
          -- ["@lsp.type.selfKeyword"] = { fg = colors.pink },
          -- ["@ibl.indent.char.1"] = { fg = colors.surface2 },
          -- ["@ibl.scope.char.1"] = { fg = colors.pink },
        }
      end,
      integrations = {
        treesitter = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        rainbow_delimiters = true,
        render_markdown = true,
        which_key = true,
        indent_blankline = {
          enabled = true,
          scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        snacks = {
          enabled = true,
          indent_scope_color = "flamingo",
        },
      },
    })
  end,
}
