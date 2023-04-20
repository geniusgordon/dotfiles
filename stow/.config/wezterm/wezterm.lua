-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Catppuccin Mocha'

config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Medium", stretch = "Normal", style = "Normal" })
config.font_size = 24.0
config.font_rules = {
  {
    italic = true,
    font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Medium", stretch = "Normal", style = "Italic" }),
  },
  {
    intensity = "Bold",
    font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Bold", stretch = "Normal", style = "Normal" }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Bold", stretch = "Normal", style = "Italic" })
  },
}

config.hide_tab_bar_if_only_one_tab = true

return config
