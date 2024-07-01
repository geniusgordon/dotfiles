local M = {}

local theme = require("gordon.lib.theme")

M.setup_colors = function()
  local colorpairs = {
    { "red", theme.theme.colors.red },
    { "green", theme.theme.colors.green },
    { "blue", theme.theme.colors.blue },
    { "yellow", theme.theme.colors.orange },
    { "cyan", theme.theme.colors.cyan },
    { "magenta", theme.theme.colors.magenta },
    { "red", theme.theme.colors.red },
    { "green", theme.theme.colors.green },
    { "blue", theme.theme.colors.blue },
    { "yellow", theme.theme.colors.orange },
    { "cyan", theme.theme.colors.cyan },
    { "magenta", theme.theme.colors.magenta },
  }
  vim.g.rcsv_colorpairs = colorpairs

  local id = vim.api.nvim_create_augroup("rcsv", { clear = true })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = id,
    pattern = "*.csv",
    callback = function()
      vim.api.nvim_set_hl(0, "Number", {})
      vim.api.nvim_set_hl(0, "String", {})
      vim.api.nvim_set_hl(0, "Constant", {})
      vim.api.nvim_set_hl(0, "@header", { bold = true })
    end,
  })
end

M.arrange_column = function()
  vim.api.nvim_command("RainbowAlign")
end

M.unarrange_column = function()
  vim.api.nvim_command("RainbowShrink")
end

M.setup = function()
  M.setup_colors()
end

return M
