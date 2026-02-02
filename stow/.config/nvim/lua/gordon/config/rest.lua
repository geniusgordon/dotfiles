require("rest-nvim").setup()

vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = function(event)
    local wk = require("which-key")
    wk.add({
      mode = { "n" },
      {
        "<leader>S",
        ":Rest run<CR>",
        desc = "RestNvim",
        buffer = event.buf,
      },
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

  vim.cmd("cd " .. path)

  local api = require("nvim-tree.api")
  api.tree.open()
  api.tree.change_root(path)
end

local wk = require("which-key")
wk.add({
  mode = { "n" },
  {
    "<leader>rs",
    function()
      open_saved_request(saved_rest_path)
    end,
    desc = "Open saved rest requests",
  },
  {
    "<leader>rg",
    function()
      open_saved_request(saved_graphql_path)
    end,
    desc = "Open saved GraphQL requests",
  },
})
