local wezterm = require("wezterm")

return function(config)
	local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
	bar.apply_to_config(config, {
		position = "top",
		padding = {
			left = 1,
			right = 1,
			tabs = { left = 1, right = 1 },
		},
		separator = { space = 1, left_icon = "", right_icon = "", field_icon = " | " },
		modules = {
			workspace = { enabled = true, icon = wezterm.nerdfonts.cod_window, color = 5 },
			leader = { enabled = true, icon = wezterm.nerdfonts.oct_rocket, color = 2 },
			pane = { enabled = false },
			clock = { enabled = false },
			hostname = { enabled = false },
			-- spotify = { enabled = true }, -- example override
		},
	})
end
