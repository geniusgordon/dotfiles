local nvim_tmux_nav = require('nvim-tmux-navigation')

nvim_tmux_nav.setup {
  disable_when_zoomed = true -- defaults to false
}

vim.keymap.set('n', "<C-w>h", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-w>j", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-w>k", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-w>l", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set('n', "<C-w>\\", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set('n', "<C-w>Space", nvim_tmux_nav.NvimTmuxNavigateNext)
