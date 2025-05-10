-- init.lua
-- 1) Clone lazy.nvim if it's not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
-- 2) Prepend to runtime path
vim.opt.rtp:prepend(lazypath)
-- opts.rocks.hererocks = false

-- 3) Import all specs under lua/plugins/
require("lazy").setup({ spec = { { import = "plugins" } } })

-- 4) General settings
vim.opt.number = true
vim.g.mapleader = ' '
vim.g.have_nerd_font = true