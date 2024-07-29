local util = require("gordon.lib.theme.util")

local M = {}

M.colors = util.createColorPalatte({
  none = "NONE",
  bg = "#181616",
  fg = "#c5c9c5",
  fg_light = "#625e5a",
  bg_light = "#282727",
  bg_visual = "#223249",
  bg_cursor_line = "#393836",
  line = "#54546D",
  line_dark = "#54546D",
  red = "#c4746e",
  orange = "#FF9E3B",
  yellow = "#c4b28a",
  green = "#8a9a7b",
  cyan = "#8ea4a2",
  blue = "#8ba4b0",
  magenta = "#a292a3",
})

return M
