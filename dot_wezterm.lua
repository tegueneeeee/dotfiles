local wezterm = require("wezterm")
local act = wezterm.action

local fish_path = "/opt/homebrew/bin/fish"

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Settings
config.default_prog = { fish_path, "-l" }
config.color_scheme = "Catppuccin Frappe"
local custom_colors = {
	red = "#E78284",
	teal = "#81C8BE",
	mauve = "#CA9EE6",
	yellow = "#E5C890",
}

config.font = wezterm.font_with_fallback({
	{ family = "HackGen Console NF", scale = 1.35 },
})
config.window_background_opacity = 0.8
config.macos_window_background_blur = 24
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

-- Keys
config.keys = {
	-- Activate leader_mode using physical 'A' key (Works for both EN 'a' and KR 'ㅁ')
	{
		key = "phys:A",
		mods = "CTRL",
		action = act.ActivateKeyTable({
			name = "leader_mode",
			one_shot = true,
		}),
	},
}

config.key_tables = {
	-- Main command mode
	leader_mode = {
		-- Move to start of line (Ctrl+a)
		{ key = "phys:A", mods = "CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },

		-- Tab management
		{ key = "phys:C", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "phys:W", action = act.ShowTabNavigator },
		{ key = "phys:P", action = act.ActivateTabRelative(-1) },
		{ key = "phys:N", action = act.ActivateTabRelative(1) },
		{
			key = "phys:Comma",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Renaming Tab Title...:" },
				}),
				action = wezterm.action_callback(function(window, _, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		-- Switch to tab movement table
		{ key = "phys:Period", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },

		-- Pane management
		{ key = '"', action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "%", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "phys:H", action = act.ActivatePaneDirection("Left") },
		{ key = "phys:J", action = act.ActivatePaneDirection("Down") },
		{ key = "phys:K", action = act.ActivatePaneDirection("Up") },
		{ key = "phys:L", action = act.ActivatePaneDirection("Right") },
		{ key = "phys:Space", action = act.RotatePanes("Clockwise") },
		{ key = "phys:Z", action = act.TogglePaneZoomState },
		{ key = "phys:X", action = act.CloseCurrentPane({ confirm = true }) },
		{
			key = "!",
			mods = "SHIFT",
			action = wezterm.action_callback(function(_, pane)
				local tab, window = pane:move_to_new_tab()
			end),
		},

		-- Utilities
		{ key = "phys:LeftBracket", action = act.ActivateCopyMode },
		{ key = ":", action = act.ActivateCommandPalette },
		{ key = "phys:S", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
		{ key = "phys:R", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
		{ key = "Escape", action = "PopKeyTable" },
	},

	-- Key table for resizing panes
	resize_pane = {
		{ key = "phys:Comma", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) }, -- <
		{ key = "phys:Minus", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "phys:Equal", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) }, -- +
		{ key = "phys:Period", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) }, -- >
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},

	-- Key table for moving tabs
	move_tab = {
		{ key = "phys:H", action = act.MoveTabRelative(-1) },
		{ key = "phys:J", action = act.MoveTabRelative(-1) },
		{ key = "phys:K", action = act.MoveTabRelative(1) },
		{ key = "phys:L", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

-- Quickly navigate tabs with index (inside leader_mode)
for i = 1, 9 do
	table.insert(config.key_tables.leader_mode, {
		key = tostring(i),
		action = act.ActivateTab(i - 1),
	})
end

-- Tab bar appearance
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = true

-- Update status bar info
wezterm.on("update-status", function(window, pane)
	local stat = window:active_workspace()
	local stat_color = custom_colors.red

	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = custom_colors.teal
		if stat == "leader_mode" then
			stat = "LDR"
			stat_color = custom_colors.mauve
		end
	end

	local basename = function(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	local cwd = pane:get_current_working_dir()
	cwd = cwd and basename(cwd.file_path) or ""

	local cmd = pane:get_foreground_process_name()
	cmd = cmd and basename(cmd) or ""

	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = "  " },
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		{ Text = " |" },
	}))

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = custom_colors.yellow } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		{ Text = "  " },
	}))
end)

return config
