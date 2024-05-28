local M = {}

M.setup = function()
  require('neo-tree').setup()
  vim.keymap.set("n", "<leader>t", ':Neotree toggle<cr>')
  vim.keymap.set("n", "<leader>pv", ':Neotree reveal<cr>')
end

return M
