return {
  "lervag/vimtex",
  lazy = false, -- load immediately for all TeX files
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- PDF viewer
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_view_skim_activate = 1
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_reading_bar = 1

    -- Compiler: use tectonic
    vim.g.vimtex_compiler_method = "tectonic"

    -- Optional: disable quickfix auto-open
    vim.g.vimtex_quickfix_mode = 0
  end,
}
