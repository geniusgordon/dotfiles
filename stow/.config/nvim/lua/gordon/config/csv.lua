local csv = require("gordon.lib.csv")

csv.setup()

vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  callback = function()
    vim.keymap.set("n", "<leader>cc", csv.arrange_column, {
      noremap = true,
      silent = true,
      desc = "Arrange column",
    })

    vim.keymap.set("n", "<leader>cu", csv.unarrange_column, {
      noremap = true,
      silent = true,
      desc = "Unarrange column",
    })
  end,
})
