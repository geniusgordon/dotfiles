-- Install parsers
require("nvim-treesitter").install({
  "bash",
  "c",
  "cmake",
  "comment",
  "cpp",
  "css",
  "csv",
  "diff",
  "dockerfile",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "graphql",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "kotlin",
  "latex",
  "lua",
  "passwd",
  "python",
  "ruby",
  "rust",
  "solidity",
  "sql",
  "svelte",
  "swift",
  "terraform",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vue",
  "xml",
  "yaml",
})

-- Highlight is enabled by default in Neovim when treesitter parsers are available.
-- Disable for large files via autocommand.
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function(args)
    local max_filesize = 2 * 1024 * 1024 -- 2MB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      vim.treesitter.stop(args.buf)
    end
  end,
})

-- Textobjects
require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
      ["@class.outer"] = "<c-v>",
    },
    include_surrounding_whitespace = true,
  },
  move = {
    set_jumps = true,
  },
})

-- Textobject select keymaps
local select_textobject = function(query)
  return function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end
end

vim.keymap.set({ "x", "o" }, "af", select_textobject("@function.outer"), { desc = "Select outer function" })
vim.keymap.set({ "x", "o" }, "if", select_textobject("@function.inner"), { desc = "Select inner function" })
vim.keymap.set({ "x", "o" }, "ac", select_textobject("@class.outer"), { desc = "Select outer class" })
vim.keymap.set({ "x", "o" }, "ic", select_textobject("@class.inner"), { desc = "Select inner class" })
vim.keymap.set({ "x", "o" }, "as", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@scope", "locals")
end, { desc = "Select language scope" })
vim.keymap.set({ "x", "o" }, "aF", select_textobject("@field.outer"), { desc = "Select outer field" })
vim.keymap.set({ "x", "o" }, "iF", select_textobject("@field.inner"), { desc = "Select inner field" })

-- Textobject move keymaps
vim.keymap.set({ "n", "x", "o" }, "]F", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@field.inner", "textobjects")
end, { desc = "Next field start" })
vim.keymap.set({ "n", "x", "o" }, "[F", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@field.inner", "textobjects")
end, { desc = "Previous field start" })

-- Treesitter context
require("treesitter-context").setup({
  enable = true,
  max_lines = 3,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = "inner",
  mode = "cursor",
  separator = nil,
  zindex = 20,
  on_attach = nil,
})

vim.keymap.set(
  "n",
  "<C-h>",
  ":Inspect<CR>",
  { noremap = true, silent = true, desc = "Highlight Captures Under Cursor" }
)
