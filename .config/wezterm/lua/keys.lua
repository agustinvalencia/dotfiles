local wezterm = require("wezterm")

return function(config)
	config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

	config.keys = {
		-- moving between panes
		{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },

		-- Tab to change previous tab
		{ key = "Tab", mods = "LEADER", action = wezterm.action.ActivateLastTab },

		-- pane splitting
		{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "/", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

		-- pane reordering
		{ key = "u", mods = "LEADER", action = wezterm.action.MoveTabRelative(-1) },
		{ key = "i", mods = "LEADER", action = wezterm.action.MoveTabRelative(1) },

		-- maximising pane
		{ key = "=", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },

		-- command palette
		{ key = "p", mods = "SHIFT|CMD", action = wezterm.action.ActivateCommandPalette },

		-- close panes
		{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = false }) },

		-- copy and paste
		{ key = "c", mods = "CMD", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
		{ key = "v", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },

		-- Renaming tabs
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

		-- Handy: force reload the config (even if auto reload is off)
		{ key = "R", mods = "CMD|SHIFT", action = wezterm.action.ReloadConfiguration },
	}
end
