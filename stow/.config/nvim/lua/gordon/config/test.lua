-- let test#strategy = "dispatch"
vim.cmd("let test#strategy = 'vimux'")

vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", {
  noremap = true,
  silent = true,
  desc = "Test Nearest",
})

vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", {
  noremap = true,
  silent = true,
  desc = "Test File",
})

vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", {
  noremap = true,
  silent = true,
  desc = "Test Suite",
})

vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", {
  noremap = true,
  silent = true,
  desc = "Test Last",
})

vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", {
  noremap = true,
  silent = true,
  desc = "Test Visit",
})
