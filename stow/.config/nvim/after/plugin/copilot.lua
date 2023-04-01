vim.g.copilot_filetypes = {
  gitcommit = true,
  markdown = true,
  yaml = true
}

vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)")
vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)")
vim.keymap.set("i", "<C-l>", "<Plug>(copilot-suggest)")
