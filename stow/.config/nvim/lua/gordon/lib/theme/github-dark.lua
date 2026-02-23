local util = require("gordon.lib.theme.util")

local M = {}

M.colors = util.createColorPalatte({
  none             = "NONE",
  bg               = "#010409",
  fg               = "#e6edf3",
  fg_light         = "#6e7681",
  bg_light         = "#161b22",
  bg_visual        = "#264f78",
  bg_cursor_line   = "#0d1117",
  line             = "#30363d",
  line_dark        = "#21262d",
  red              = "#ff7b72",
  orange           = "#e3b341",
  yellow           = "#d29922",
  green            = "#3fb950",
  cyan             = "#39c5cf",
  blue             = "#58a6ff",
  magenta          = "#bc8cff",
})

return M
