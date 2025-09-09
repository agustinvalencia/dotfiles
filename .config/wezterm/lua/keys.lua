local wezterm = require("wezterm")

return function(config)
	config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

	config.keys = {
		{ key = "p", mods = "SHIFT|CMD", action = wezterm.action.ActivateCommandPalette },
		{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
		{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "/", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "t", mods = "LEADER", action = wezterm.action.ShowTabNavigator },
		{ key = "c", mods = "CMD", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
		{ key = "V", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
		{
			key = "r",
			mods = "LEADER",
			action = wezterm.action.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{ key = "Tab", mods = "LEADER", action = wezterm.action.ActivateLastTab },

		-- Handy: force reload the config (even if auto reload is off)
		{ key = "R", mods = "CMD|SHIFT", action = wezterm.action.ReloadConfiguration },
	}
end
