local wezterm = require("wezterm")

-- Make local `lua/` importable:
package.path = package.path .. ";" .. wezterm.config_dir .. "/?.lua" .. ";" .. wezterm.config_dir .. "/?/init.lua"

local appearance = require("lua.appearance")
local keys = require("lua.keys")
local bar_cfg = require("lua.bar")
local title = require("lua.title")

local config = wezterm.config_builder()

-- apply modules (each mutates `config`)
appearance(config)
keys(config)
bar_cfg(config)
title(config)

return config
