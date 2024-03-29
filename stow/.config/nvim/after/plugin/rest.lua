require("rest-nvim").setup({
  -- Open request results in a horizontal split
  result_split_horizontal = false,
  -- Keep the http file buffer above|left when split horizontal|vertical
  result_split_in_place = false,
  -- Skip SSL verification, useful for unknown certificates
  skip_ssl_verification = false,
  -- Encode URL before making request
  encode_url = true,
  -- Highlight request on run
  highlight = {
    enabled = true,
    timeout = 150,
  },
  result = {
    -- toggle showing URL, HTTP info, headers at top the of result window
    show_url = true,
    show_http_info = true,
    show_headers = true,
    -- executables or functions for formatting response body [optional]
    -- set them to false if you want to disable them
    formatters = {
      json = "jq",
      html = function(body)
        return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
      end,
    },
  },
  -- Jump to request line on run
  jump_to_request = false,
  env_file = ".env",
  custom_dynamic_variables = {},
  yank_dry_run = true,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = function(event)
    vim.keymap.set("n", "<leader>S", "<Plug>RestNvim", {
      noremap = true,
      silent = true,
      desc = "RestNvim",
      buf = event.buffer,
    })

    -- <Plug>RestNvimPreview
    vim.keymap.set("n", "<leader>rp", "<Plug>RestNvimPreview", {
      noremap = true,
      silent = true,
      desc = "RestNvimPreview",
      buf = event.buffer,
    })
  end,
})

local saved_rest_path = vim.fn.fnamemodify("~/.local/share/rest-nvim/rest", ":p")
local saved_graphql_path = vim.fn.fnamemodify("~/.local/share/rest-nvim/graphql", ":p")

local open_saved_request = function(p)
  local path = vim.fn.fnamemodify(p, ":p")

  if vim.fn.isdirectory(path) == 0 then
    vim.fn.mkdir(path, "p")
  end

  local api = require("nvim-tree.api")
  api.tree.open()
  api.tree.change_root(path)
end

vim.keymap.set("n", "<leader>rs", function()
  open_saved_request(saved_rest_path)
end, {
  noremap = true,
  silent = true,
  desc = "Open saved rest requests",
})

vim.keymap.set("n", "<leader>rg", function()
  open_saved_request(saved_graphql_path)
end, {
  noremap = true,
  silent = true,
  desc = "Open saved GraphQL requests",
})
