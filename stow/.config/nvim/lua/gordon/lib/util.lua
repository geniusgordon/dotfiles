local M = {}

M.get_script_dir = function()
  local info = debug.getinfo(2, "S")
  local script_path = info.source:sub(2) -- Remove the @ prefix
  return vim.fn.fnamemodify(script_path, ":p:h")
end

return M
