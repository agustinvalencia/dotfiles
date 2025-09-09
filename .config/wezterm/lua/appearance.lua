local wezterm = require("wezterm")
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

return function(config)
	config.font_size = 14
	config.line_height = 1
	config.font = wezterm.font_with_fallback({
		{ family = "Fira Code", weight = "Medium" },
		"Symbols Nerd Font Mono",
		"FiraCode Nerd Font Mono",
	})
	config.freetype_load_target = "Light"

	config.color_scheme = "catppuccin-mocha"
	config.window_decorations = "RESIZE"
	config.window_background_opacity = 0.97
	config.text_background_opacity = 1

	config.window_padding = { left = 2, right = 2, top = 0, bottom = 0 }

	config.colors = {
		cursor_bg = "#7aa2f7",
		cursor_border = "#7aa2f7",
		tab_bar = {
			background = "#1e1e2e",
			active_tab = { fg_color = "#1e1e2e", bg_color = "#f5c2e7" },
			inactive_tab = { bg_color = "#313244", fg_color = "#cdd6f4" },
			new_tab = { bg_color = "#1e1e2e", fg_color = "#f5c2e7" },
		},
	}

	-- bar/tabs need this visible
	config.enable_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = false
end
