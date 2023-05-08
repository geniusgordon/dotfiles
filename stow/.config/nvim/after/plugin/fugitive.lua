vim.keymap.set('n', '<leader>gs', vim.cmd.Git, {
  noremap = true, silent = true, desc = 'Git status'
})

vim.keymap.set('n', '<leader>gd', vim.cmd.Gvdiffsplit, {
  noremap = true, silent = true, desc = 'Git diff split'
})
