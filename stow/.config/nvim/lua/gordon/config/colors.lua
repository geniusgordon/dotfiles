-- local colorscheme = "tokyonight-night"
local colorscheme = "catppuccin-mocha"
vim.cmd.colorscheme(colorscheme)

require("catppuccin").setup({
  flavour = "mocha",
})

local colors = require("gordon.lib.colors").base_30
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.one_bg3 })
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.white })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.one_bg3 })
vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.one_bg3 })
vim.api.nvim_set_hl(0, "Visual", { bg = colors.one_bg3 })
