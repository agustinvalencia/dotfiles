-- init.lua

-- 1) load configs
require("configs")

-- 2) Clone lazy.nvim if it's not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end

-- 3) Prepend to runtime path
vim.opt.rtp:prepend(lazypath)
-- opts.rocks.hererocks = false

-- 4) Import all specs under lua/plugins/
require("lazy").setup({ spec = { { import = "plugins" } } })

