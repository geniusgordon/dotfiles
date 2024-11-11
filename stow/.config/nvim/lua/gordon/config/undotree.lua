local wk = require("which-key")

wk.add({
  {
    mode = { "n" },
    { "<leader>u", ":UndotreeToggle<CR>", desc = "Toggle undotree" },
  },
})
