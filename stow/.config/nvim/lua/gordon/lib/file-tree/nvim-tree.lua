local M = {}

M.setup = function()
  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true

  -- empty setup using defaults
  require("nvim-tree").setup({
    view = {
      width = 35,
    },
    actions = {
      open_file = {
        -- quit_on_open = true,
      },
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          folder_arrow = false,
        },
      },
    },
  })

  local wk = require("which-key")
  wk.add({
    {
      mode = { "n" },
      { "<leader>e", ":NvimTreeToggle<cr>", desc = "Toggle Tree" },
      { "<leader>E", ":NvimTreeFindFile<cr>", desc = "Find File in Tree" },
    },
  })
end

return M
