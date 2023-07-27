local telescope = require('telescope')

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    layout_config = {
      horizontal = {
        -- preview_width = 0.5,
      },
    },
  }
})

telescope.load_extension('fzf')
telescope.load_extension('dap')
telescope.load_extension('ui-select')
telescope.load_extension('tmux')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>p', '<nop>', {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>pa', function()
  builtin.find_files({
    hidden = true,
    no_ignore = true,
  })
end, { desc = 'Find all files' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Find buffers' })

vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Find git branches' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Find files in git' })

vim.keymap.set('n', '<leader>ph', builtin.highlights, { desc = 'Find highlights' })

vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = 'Grep for string' })

vim.keymap.set("n", "<leader>bw", ":Telescope tmux windows<CR>", { desc = "Find tmux windows" })
vim.keymap.set("n", "<leader>bs", ":Telescope tmux sessions<CR>", { desc = "Find tmux sessions" })

local colors = require("gordon.catppuccin").base_30

vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = colors.red, bg = colors.black2 })
vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = colors.black })
vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = colors.black, bg = colors.green })
vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = colors.black, bg = colors.blue })

vim.api.nvim_set_hl(0, 'TelescopeResultsDiffAdd', { fg = colors.green })
vim.api.nvim_set_hl(0, 'TelescopeResultsDiffChange', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'TelescopeResultsDiffDelete', { fg = colors.red })

vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = colors.one_bg3 })
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = colors.one_bg3 })
vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = colors.black, bg = colors.green })
vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = colors.black, bg = colors.blue })
vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = colors.red, bg = colors.black })
vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = colors.black })
vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = colors.black })
