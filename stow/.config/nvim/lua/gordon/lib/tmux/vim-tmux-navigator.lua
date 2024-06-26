local nvim_tmux_nav = require("nvim-tmux-navigation")

local M = {}

M.setup = function()
  nvim_tmux_nav.setup({
    disable_when_zoomed = true, -- defaults to false
  })

  vim.keymap.set("n", "<C-w>h", nvim_tmux_nav.NvimTmuxNavigateLeft)
  vim.keymap.set("n", "<C-w>j", nvim_tmux_nav.NvimTmuxNavigateDown)
  vim.keymap.set("n", "<C-w>k", nvim_tmux_nav.NvimTmuxNavigateUp)
  vim.keymap.set("n", "<C-w>l", nvim_tmux_nav.NvimTmuxNavigateRight)
  vim.keymap.set("n", "<C-w>\\", nvim_tmux_nav.NvimTmuxNavigateLastActive)
  vim.keymap.set("n", "<C-w>Space", nvim_tmux_nav.NvimTmuxNavigateNext)

  vim.keymap.set("n", "<M-j>", function()
    vim.cmd("horizontal resize +5")
  end, { desc = "Increase height" })
  vim.keymap.set("n", "<M-k>", function()
    vim.cmd("horizontal resize -5")
  end, { desc = "Decrease height" })
  vim.keymap.set("n", "<M-h>", function()
    vim.cmd("vertical resize +5")
  end, { desc = "Increase width" })
  vim.keymap.set("n", "<M-l>", function()
    vim.cmd("vertical resize -5")
  end, { desc = "Decrease width" })
end

return M
