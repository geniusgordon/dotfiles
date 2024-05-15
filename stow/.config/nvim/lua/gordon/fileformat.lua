local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local fileformat = function(opts)
  opts = opts or {}

  pickers.new(opts, {
    prompt_title = "File Format",
    finder = finders.new_table({
      results = {
        'unix', 'dos', 'mac'
      }
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd('set fileformat=' .. selection.value)
      end)
      return true
    end,
  }):find()
end

local M = {}

M.set_fileformat = function()
  fileformat()
end

return M
