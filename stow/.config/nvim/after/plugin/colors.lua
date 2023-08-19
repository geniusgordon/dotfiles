function ColorMyPencils(color)
  color = color or "catppuccin"

  require("catppuccin").setup({
    flavour = "macchiato",
  })

  vim.cmd.colorscheme(color)

  local colors = require("gordon.catppuccin").base_30
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.one_bg3 })
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors.white })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.one_bg3 })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.one_bg3 })
end

ColorMyPencils()
