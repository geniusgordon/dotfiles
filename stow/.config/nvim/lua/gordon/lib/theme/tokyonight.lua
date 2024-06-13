local util = require("gordon.lib.theme.util")

local M = {}

M.colors = util.createColorPalatte({
  none = "NONE",
  bg = "#1a1b26",
  fg = "#c0caf5",
  fg_light = "#3b4261",
  bg_visual = "#182440",
  bg_cursor_line = "#292e42",
  line = "#3b4261",
  blue = "#7aa2f7",
  cyan = "#7dcfff",
  magenta = "#bb9af7",
  purple = "#9d7cd8",
  orange = "#ff9e64",
  yellow = "#e0af68",
  green = "#9ece6a",
  red = "#f7768e",
})

return M
