require("ibl").setup({
  indent = { char = "│" },
})

local colors = require("gordon.lib.colors").base_30
vim.api.nvim_set_hl(0, "@ibl.indent.char.1", { fg = colors.light_grey })
vim.api.nvim_set_hl(0, "@ibl.whitespace.char.1", { fg = colors.light_grey })
vim.api.nvim_set_hl(0, "@ibl.scope.char.1", { fg = colors.blue })
