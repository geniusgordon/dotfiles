-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font_with_fallback({
  {
    family = "JetBrainsMono Nerd Font",
    weight = "Medium",
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
    key = 'Q',
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

return config
