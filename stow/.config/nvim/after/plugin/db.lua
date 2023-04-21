vim.g.db_ui_use_nerd_fonts = true
vim.keymap.set('n', '<leader>dg', ':DBUIToggle<CR>', {
  noremap = true, silent = true, desc = 'Toggle DBUI'
})
