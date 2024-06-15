local M = {}
local oil = require("oil")

M.setup = function()
  oil.setup({
    default_file_explorer = true,
    delete_to_trash = true,
  })

  vim.keymap.set("n", "-", function()
    oil.open()
  end, { noremap = true, silent = true, desc = "Open file explorer" })
end

return M
