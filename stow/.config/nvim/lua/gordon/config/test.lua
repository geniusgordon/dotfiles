-- vim.cmd("let test#strategy = 'vimux'")
vim.cmd("let test#strategy = 'neovim_sticky'")
vim.cmd("let g:test#neovim_sticky#kill_previous = 1") -- Try to abort previous run
vim.cmd("let g:test#preserve_screen = 0") -- Clear screen from previous run
vim.cmd("let test#neovim_sticky#reopen_window = 1") -- Reopen terminal split if not visible

vim.keymap.set("n", "<leader>Tn", ":TestNearest<CR>", {
  noremap = true,
  silent = true,
  desc = "Test Nearest",
})

vim.keymap.set("n", "<leader>Tf", ":TestFile<CR>", {
  noremap = true,
  silent = true,
  desc = "Test File",
})

vim.keymap.set("n", "<leader>Ts", ":TestSuite<CR>", {
  noremap = true,
  silent = true,
  desc = "Test Suite",
})

vim.keymap.set("n", "<leader>Tl", ":TestLast<CR>", {
  noremap = true,
  silent = true,
  desc = "Test Last",
})

vim.keymap.set("n", "<leader>Tv", ":TestVisit<CR>", {
  noremap = true,
  silent = true,
  desc = "Test Visit",
})
