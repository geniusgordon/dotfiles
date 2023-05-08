local gs = require('gitsigns')

gs.setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
}

local colors = require('gordon.catppuccin').base_30
vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = colors.light_grey })
vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { fg = colors.red })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = colors.red })
