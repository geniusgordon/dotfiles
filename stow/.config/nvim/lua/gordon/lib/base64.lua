local M = {}

---@description Get the visual selection
---@class VisualSelection
---@field start_pos table
---@field end_pos table
---@field text string
---@return VisualSelection | nil
local function get_visual_selection()
  local mode = vim.api.nvim_get_mode().mode

  if mode ~= "v" and mode ~= "V" then
    return nil
  end

  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)

  if #lines == 0 then
    return nil
  end

  if mode == "v" then
    lines[1] = string.sub(lines[1], start_pos[3])
    if #lines == 1 then
      lines[#lines] = string.sub(lines[1], 1, end_pos[3] - start_pos[3] + 1)
    else
      lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    end
  end
  local text = table.concat(lines, "\n")

  return {
    start_pos = start_pos,
    end_pos = end_pos,
    text = text,
  }
end

M.setup = function()
  M.namespace = vim.api.nvim_create_namespace("base64")
end

M.set_diagnostic = function(message, line, col)
  vim.diagnostic.set(M.namespace, 0, {
    {
      lnum = line,
      col = col,
      message = message,
      source = "base64",
      severity = vim.diagnostic.severity.INFO,
    },
  })
end

M.encode_visual_selection = function()
  local selection = get_visual_selection()
  if not selection then
    return
  end

  local encoded = vim.fn.system("echo '" .. selection.text .. "' | base64")
  local message = string.format("Original:\n%s\nEncoded:\n%s", selection.text, encoded)
  M.set_diagnostic(message, selection.start_pos[2] - 1, selection.start_pos[3])
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
  vim.diagnostic.open_float({ focusable = true })
end

M.decode_visual_selection = function()
  local selection = get_visual_selection()
  if not selection then
    return
  end

  local decoded = vim.fn.system("echo '" .. selection.text .. "' | base64 -d")
  local message = string.format("Original:\n%s\nDecoded:\n%s", selection.text, decoded)
  M.set_diagnostic(message, selection.start_pos[2] - 1, selection.start_pos[3])
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
  vim.diagnostic.open_float({ focusable = true })
end

M.clear_diagnostic = function()
  vim.diagnostic.reset(M.namespace, 0)
end

return M
