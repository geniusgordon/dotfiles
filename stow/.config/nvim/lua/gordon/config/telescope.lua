local telescope = require("telescope")
local encoding = require("gordon.lib.encoding")

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    layout_config = {
      horizontal = {
        -- preview_width = 0.5,
      },
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("dap")
telescope.load_extension("ui-select")
telescope.load_extension("tmux")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>p", "<nop>", {})
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>pa", function()
  builtin.find_files({
    hidden = true,
    no_ignore = true,
  })
end, { desc = "Find all files" })
vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Find buffers" })

vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Find git branches" })
-- vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Find files in git' })

vim.keymap.set("n", "<leader>ph", builtin.highlights, { desc = "Find highlights" })

vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Grep for string" })

vim.keymap.set("n", "<leader>pc", function()
  builtin.grep_string()
end, { desc = "Grep for word under cursor" })

vim.keymap.set("n", "<leader>bw", ":Telescope tmux windows<CR>", { desc = "Find tmux windows" })
vim.keymap.set("n", "<leader>bs", ":Telescope tmux sessions<CR>", { desc = "Find tmux sessions" })

vim.keymap.set("n", "<leader>pr", function()
  encoding.open_with_encoding()
end, { desc = "Open file with encoding" })
vim.keymap.set("n", "<leader>pe", function()
  encoding.save_with_encoding()
end, { desc = "Save file with encoding" })
