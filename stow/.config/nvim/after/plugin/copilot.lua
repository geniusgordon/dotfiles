-- vim.g.copilot_filetypes = {
--   gitcommit = true,
--   markdown = true,
--   yaml = true
-- }
--
-- vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)")
-- vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)")
-- vim.keymap.set("i", "<C-l>", "<Plug>(copilot-suggest)")
--
require('copilot').setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<Tab>",
      accept_word = false,
      accept_line = false,
      next = "<C-j>",
      prev = "<C-k>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {},
})
