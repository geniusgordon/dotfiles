local M = {}

M.toggle_header = function()
  vim.api.nvim_command("HeaderToggle")
end

M.toggle_vheader = function()
  vim.api.nvim_command("VHeaderToggle")
end

M.arrange_column = function()
  vim.api.nvim_command("%CSVArrangeColumn")
end

M.unarrange_column = function()
  vim.api.nvim_command("%CSVUnArrangeColumn")
end

return M
