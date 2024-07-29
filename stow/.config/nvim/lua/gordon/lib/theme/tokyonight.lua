local util = require("gordon.lib.theme.util")

local M = {}

M.colors = util.createColorPalatte({
  none = "NONE",
  bg = "#1a1b26",
  fg = "#c0caf5",
  fg_light = "#3b4261",
  bg_light = "#292e42",
  bg_visual = "#182440",
  bg_cursor_line = "#292e42",
  line = "#3b4261",
  line_dark = "#3b4261",
  red = "#f7768e",
  orange = "#ff9e64",
  yellow = "#e0af68",
  green = "#9ece6a",
  cyan = "#7dcfff",
  blue = "#7aa2f7",
  magenta = "#bb9af7",
})

return M
