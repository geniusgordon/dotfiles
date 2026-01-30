local M = {}

M.setup = function()
  local wk = require("which-key")

  wk.add({
    { "<leader>g", group = "Git" },
    {
      mode = { "n" },
      { "<leader>gs", ":vertical Git<CR>", desc = "Git status" },
      { "<leader>gd", ":DiffviewOpen<CR>", desc = "Git diff split" },
      { "<leader>gf", ":DiffviewFileHistory %<CR>", desc = "Git file history" },
      { "<leader>gc", ":DiffviewClose<CR>", desc = "Git close diff" },
      { "<leader>gl", ":vertical Git log --oneline<CR>", desc = "Git log" },
    },
  })
end

return M
