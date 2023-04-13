local M = {}

M.setup = function()
  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true

  -- empty setup using defaults
  require("nvim-tree").setup({
    actions = {
      open_file = {
        quit_on_open = true,
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
      }
    }
  })

  vim.keymap.set("n", "<leader>t", ':NvimTreeToggle<cr>')
  vim.keymap.set("n", "<leader>pv", ':NvimTreeFindFile<cr>')

  local function open_nvim_tree(data)
    if #vim.fn.argv() == 0 and not vim.o.insertmode then
      require("nvim-tree.api").tree.open()
      return
    end

    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
      return
    end

    -- change to the directory
    print(data.file)
    vim.cmd.cd(data.file)

    -- open the tree
    require("nvim-tree.api").tree.open()
  end

  vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

  local colors = require("gordon.catppuccin").base_30
  vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = colors.one_bg3 })
end

return M
