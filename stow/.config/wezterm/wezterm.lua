-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Kanagawa Dragon (Gogh)"

config.colors = {
	-- background = "#181616",
}

config.font = wezterm.font_with_fallback({
	{
		family = "JetBrainsMono Nerd Font",
		weight = "Light",
		stretch = "Normal",
		style = "Normal",
		harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	},
	{ family = "Noto Sans TC", weight = "Medium", stretch = "Normal", style = "Normal" },
	{ family = "Noto Sans JP", weight = "Medium", stretch = "Normal", style = "Normal" },
})
config.font_size = 24.0

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
	{
		key = "Q",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "f",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "p",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = ";",
		mods = "OPT",
		action = wezterm.action({ SendString = "\x1b;" }),
	},
}

for i = 97, 122 do -- ASCII values for 'a' to 'z'
	table.insert(config.keys, {
		key = string.char(i),
		mods = "OPT",
		action = wezterm.action({ SendString = "\x1b" .. string.char(i) }),
	})
end

config.audible_bell = "Disabled"

-- neovim zen mode
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

return config
