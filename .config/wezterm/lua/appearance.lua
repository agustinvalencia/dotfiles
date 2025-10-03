local wezterm = require("wezterm")
-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

return function(config)
	config.font_size = 13
	config.line_height = 1
	config.font = wezterm.font_with_fallback({
		{ family = "Fira Code", weight = "Medium" },
		"Symbols Nerd Font Mono",
		"FiraCode Nerd Font Mono",
	})
	config.freetype_load_target = "Light"

	config.color_scheme = "catppuccin-mocha"
	config.window_decorations = "RESIZE"
	config.window_background_opacity = 0.9
	config.text_background_opacity = 1

	config.window_padding = {
		left = 2,
		right = 2,
		top = 2,
		bottom = 2,
	}

	config.default_cursor_style = "BlinkingBlock"
	config.colors = {
		cursor_bg = "#89b4fa",
		cursor_border = "#89b4fa",
		cursor_fg = "#6c7086",
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
	config.show_new_tab_button_in_tab_bar = false
end
