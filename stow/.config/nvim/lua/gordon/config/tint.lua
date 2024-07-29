require("tint").setup({
  tint = -60, -- Darken colors, use a positive value to brighten
  saturation = 0.5, -- Saturation to preserve
  highlight_ignore_patterns = { "WinSeparator", "Status.*" }, -- Highlight group patterns to ignore, see `string.find`
})
