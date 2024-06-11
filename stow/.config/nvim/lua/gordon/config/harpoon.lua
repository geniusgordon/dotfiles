local harpoon = require("harpoon")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")

-- REQUIRED
harpoon:setup()

vim.keymap.set("n", "<leader>h", function()
  harpoon:list():add()
  print("Added to Harpoon list: " .. vim.fn.expand("%:p:."))
end, { desc = "Add current file to Harpoon list", silent = false })

vim.keymap.set("n", "<C-n>", function()
  harpoon:list():select(1)
end, { desc = "Select Harpoon list item 1" })
vim.keymap.set("n", "<C-m>", function()
  harpoon:list():select(2)
end, { desc = "Select Harpoon list item 2" })
vim.keymap.set("n", "<C-l>", function()
  harpoon:list():select(3)
end, { desc = "Select Hampoon list item 3" })

-- basic telescope configuration
local function toggle_telescope(harpoon_files)
  local finder = function()
    local paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(paths, item.value)
    end

    return finders.new_table({
      results = paths,
    })
  end

  pickers
    .new({}, {
      prompt_title = "Harpoon",
      finder = finder(),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        map("i", "<C-d>", function()
          local selected_entry = action_state.get_selected_entry()
          local current_picker = action_state.get_current_picker(prompt_bufnr)

          table.remove(harpoon_files.items, selected_entry.index)
          current_picker:refresh(finder())
        end)
        map("i", "<C-k>", function()
          local selected_entry = action_state.get_selected_entry()
          local current_picker = action_state.get_current_picker(prompt_bufnr)

          if selected_entry.index < #harpoon_files.items then
            local temp = harpoon_files.items[selected_entry.index]
            harpoon_files.items[selected_entry.index] = harpoon_files.items[selected_entry.index + 1]
            harpoon_files.items[selected_entry.index + 1] = temp
            current_picker:refresh(finder())
          end
        end)
        map("i", "<C-j>", function()
          local selected_entry = action_state.get_selected_entry()
          local current_picker = action_state.get_current_picker(prompt_bufnr)

          if selected_entry.index > 1 then
            local temp = harpoon_files.items[selected_entry.index]
            harpoon_files.items[selected_entry.index] = harpoon_files.items[selected_entry.index - 1]
            harpoon_files.items[selected_entry.index - 1] = temp
            current_picker:refresh(finder())
          end
        end)
        return true
      end,
    })
    :find()
end

vim.keymap.set("n", "<C-e>", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })
