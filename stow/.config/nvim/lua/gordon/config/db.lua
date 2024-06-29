vim.g.db_ui_use_nerd_fonts = true
vim.g.db_ui_execute_on_save = false
vim.keymap.set("n", "<leader>dg", ":tabnew | DBUIToggle<CR>", {
  noremap = true,
  silent = true,
  desc = "Toggle DBUI",
})
