local util = require("gordon.lib.theme.util")

local M = {}

M.colors = util.createColorPalatte({
  none             = "NONE",
  bg               = "#f6f8fa",
  fg               = "#1f2328",
  fg_light         = "#57606a",
  bg_light         = "#f0f2f4",
  bg_visual        = "#add6ff",
  bg_cursor_line   = "#eff1f3",
  line             = "#d0d7de",
  line_dark        = "#eaeef2",
  red              = "#cf222e",
  orange           = "#633c01",
  yellow           = "#4d2d00",
  green            = "#116329",
  cyan             = "#1b7c83",
  blue             = "#0969da",
  magenta          = "#8250df",
})

return M
