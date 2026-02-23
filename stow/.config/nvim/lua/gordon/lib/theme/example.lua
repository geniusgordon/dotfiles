-- Example Neovim palette — copy to <name>.lua and fill in values
-- Colors must match the .sh palette for consistency.
--
-- ColorPalette fields (see util.lua):
--   bg             terminal/editor background
--   fg             foreground text
--   fg_light       dimmed text, line numbers, comments
--   bg_light       sidebars, panels, color column
--   bg_visual      visual selection background
--   bg_cursor_line cursor line background
--   line           float borders, separator lines
--   line_dark      WinSeparator (subtle)
--   red            variables, tags, diff deleted
--   orange         integers, constants, current tab
--   yellow         classes, search bg
--   green          strings, diff inserted
--   cyan           support, escape chars, quotes
--   blue           functions, methods, headings
--   magenta        keywords, storage, diff changed

local util = require("gordon.lib.theme.util")

local M = {}

M.colors = util.createColorPalatte({
  none             = "NONE",
  bg               = "#000000",
  fg               = "#ffffff",
  fg_light         = "#555555",
  bg_light         = "#1a1a1a",
  bg_visual        = "#2a2a2a",
  bg_cursor_line   = "#1a1a1a",
  line             = "#333333",
  line_dark        = "#222222",
  red              = "#ff0000",
  orange           = "#ff8800",
  yellow           = "#ffff00",
  green            = "#00ff00",
  cyan             = "#00ffff",
  blue             = "#0000ff",
  magenta          = "#ff00ff",
})

return M
