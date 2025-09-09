local wezterm = require("wezterm")
local u = require("lua.utils")
local ICON = wezterm.nerdfonts

-- map process/cwd to icon+label
local PRESETS = {
	{ match_proc = "n?vim$", icon = ICON.dev_vim, label = "nvim" },
	{ match_proc = "^python[%d.]*$", icon = ICON.dev_python, label = "python" },
	{ match_proc = "^ipython$", icon = ICON.dev_python, label = "ipynb" },
	{ match_proc = "^node$", icon = ICON.dev_nodejs_small or ICON.cod_code, label = "node" },
	{ match_proc = "^deno$", icon = ICON.cod_code, label = "deno" },
	{ match_proc = "^bun$", icon = ICON.cod_coffee, label = "bun" },
	{ match_proc = "^zsh$", icon = ICON.fa_terminal, label = "zsh" },
	{ match_proc = "^fish$", icon = ICON.fa_terminal, label = "fish" },
	{ match_cwd = "react", icon = ICON.dev_react, label = "react" },
	{ match_cwd = "next", icon = ICON.dev_react, label = "nextjs" },
}

local PLACEHOLDERS = {
	nvim = " • editing",
	python = " • venv",
	node = " • dev",
	react = " • app",
	nextjs = " • app",
}

local function make_title(pane)
	local proc = pane:get_foreground_process_name() or ""
	local name = u.basename(proc):lower()
	local cwd_uri = pane:get_current_working_dir()
	local cwd = cwd_uri and tostring(cwd_uri):gsub("^file://", "") or ""

	local icon, label
	for _, p in ipairs(PRESETS) do
		if p.match_proc and name:match(p.match_proc) then
			icon, label = p.icon, p.label
			break
		end
		if not icon and p.match_cwd and cwd:lower():match(p.match_cwd) then
			icon, label = p.icon, p.label
		end
	end

	icon = icon or ICON.cod_terminal
	label = label or (name ~= "" and name) or "shell"
	local ph = PLACEHOLDERS[label] or ""
	local tail = cwd ~= "" and u.basename(cwd) or ""
	local ctx = tail ~= "" and ("  ·  " .. tail) or ""

	return string.format(" %s  %s%s%s", icon, label, ph, ctx)
end

return function(config)
	wezterm.on("format-tab-title", function(tab)
		-- This event must be fast; no I/O here. (https://wezterm.org/config/lua/window-events/format-tab-title.html?utm_source=chatgpt.com)
		local t = make_title(tab.active_pane)
		tab:set_title(t)
		return { { Text = t } }
	end)
end
