require("markview").setup({
  markdown = {
    headings = {
      enable = true,
      shift_width = 2,
    },
  },
})

vim.keymap.set("n", "<leader>mv", "<cmd>Markview toggle<CR>", {
  noremap = true,
  silent = true,
  desc = "Toggle Markview",
})
