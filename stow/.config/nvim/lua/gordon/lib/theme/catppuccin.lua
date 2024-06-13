local util = require("gordon.lib.theme.util")

local M = {}

M.colors = util.createColorPalatte({
  none = "NONE",
  bg = "#1e1e2e",
  fg = "#cdd6f4",
  fg_light = "#45475a",
  bg_visual = "#45475a",
  bg_cursor_line = "#2A2B3C",
  line = "#6c7086",
  red = "#f38ba8",
  orange = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  cyan = "#89dceb",
  blue = "#89b4fa",
  magenta = "#cba6f7",
})

return M
