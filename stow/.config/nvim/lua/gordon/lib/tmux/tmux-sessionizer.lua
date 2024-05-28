local M = {}

M.setup = function()
  local function tmux_sessionizer()
    local cmd = "tmux new-window 'tmux-sessionizer'"
    vim.fn.system(cmd)
  end

  vim.keymap.set("n", "<C-s>", tmux_sessionizer, { desc = "Tmux sessionizer" })
end

return M
