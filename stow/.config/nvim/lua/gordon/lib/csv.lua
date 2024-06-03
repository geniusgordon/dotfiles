local M = {}
local colors = require('gordon.lib.colors').base_30

local defaultColorpairs = {
  -- { colors.red,    colors.red },
  { "red",     colors.red },
  { "blue",    colors.blue },
  { "green",   colors.green },
  { "cyan",    colors.cyan },
}

M.set_colorpairs = function(colorpairs)
  M.colorpairs = colorpairs or defaultColorpairs
  vim.g.rcsv_colorpairs = M.colorpairs
end

M.arrange_column = function()
  vim.api.nvim_command("RainbowAlign")
end

M.unarrange_column = function()
  vim.api.nvim_command("RainbowShrink")
end

M.setup = function()
  M.set_colorpairs()
end

return M
