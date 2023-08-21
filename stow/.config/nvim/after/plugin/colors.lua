function ColorMyPencils(color)
  color = "tokyonight-night"

  -- require("catppuccin").setup({
  --   flavour = "macchiato",
  -- })

  vim.cmd.colorscheme(color)

  local colors = require("gordon.colors").base_30
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.one_bg3 })
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors.white })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.one_bg3 })
  vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.one_bg3 })
end

ColorMyPencils()
