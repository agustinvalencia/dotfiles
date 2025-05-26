return {
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  "catppuccin/nvim",
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme("catppuccin-mocha")

    -- You can configure highlights by doing something like:
    vim.cmd.hi("Comment gui=none")
  end,

  config = function()
    require("catppuccin").setup({

      flavour = "macchiato",
      transparent_background = true,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },

      markdown = true,
      render_markdown = true,
      noice = true,
      which_key = true,
      default_integrations = true,
      custom_highlights = function(colors)
        return {
          NvimTreeNormal = { fg = colors.none },
          Comment = { fg = colors.flamingo },
          ["@keyword"] = { fg = colors.pink },
          ["@keyword.import"] = { fg = colors.pink },
          ["@type"] = { fg = colors.blue },
          ["@variable.parameter"] = { fg = colors.teal },
          ["@comment"] = { fg = colors.surface2, style = { "italic" } },
          ["@text.literal"] = { fg = colors.yellow },
          ["@error"] = { fg = colors.red },
          ["@string"] = { fg = colors.yellow },
          ["@string.documentation"] = { fg = colors.subtext1, style = { "italic" } },
          ["@function"] = { fg = colors.pink, bold = true },
          ["@lsp.type.selfKeyword"] = { fg = colors.pink },
          ["@ibl.indent.char.1"] = { fg = colors.surface2 },
          ["@ibl.scope.char.1"] = { fg = colors.pink },
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
      },
    })
  end,
}
