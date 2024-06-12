require("ibl").setup({
  indent = { char = "│" },
  scope = {
    show_start = false,
    show_end = false,
  },
})

local colors = require("gordon.lib.colors").base_30
vim.api.nvim_set_hl(0, "@ibl.indent.char.1", { link = "NvimTreeIndentMarker" })
vim.api.nvim_set_hl(0, "@ibl.whitespace.char.1", { link = "NvimTreeIndentMarker" })
-- vim.api.nvim_set_hl(0, "@ibl.scope.char.1", { link = "NvimTreeIndentMarker" })
vim.api.nvim_set_hl(0, "@ibl.scope.char.1", { fg = colors.blue })
