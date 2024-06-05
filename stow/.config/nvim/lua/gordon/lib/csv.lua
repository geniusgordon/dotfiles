local M = {}
local colors = require("gordon.lib.colors").base_30

local defaultColorpairs = {
  { "blue", colors.blue },
  { "yellow", colors.yellow },
  { "green", colors.green },
  { "yellow", colors.orange },
  { "cyan", colors.cyan },
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
  vim.api.nvim_set_hl(0, "@csv.header", { bold = true, fg = colors.blue })
end

return M
