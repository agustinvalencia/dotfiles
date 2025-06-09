-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- global options
vim.opt.number = true -- Make line numbers default
vim.opt.mouse = "a" -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.o.tabstop = 4 -- a TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.cmdheight = 0 -- Do not show status bar
vim.o.wrap = true -- wrap long lines
vim.o.linebreak = true -- set the wrap breaks to not break words
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.spell = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
