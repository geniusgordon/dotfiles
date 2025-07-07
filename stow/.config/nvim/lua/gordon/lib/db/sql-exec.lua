local Popup = require("nui.popup")
local Layout = require("nui.layout")

local M = {}

---------------------------------------------------------------------------
-- Configuration
---------------------------------------------------------------------------

local config = {
  preview_max_lines = 10,
  preview_edge_lines = 5,
}

---------------------------------------------------------------------------
-- Utilities
---------------------------------------------------------------------------

local function is_treesitter_available()
  local ok, _ = pcall(require, "nvim-treesitter.ts_utils")
  return ok
end

local function is_dadbod_ui_available()
  return vim.fn.hasmapto("<Plug>(DBUI_ExecuteQuery)") == 1
end

local function get_node_range_text(node)
  local start_row, start_col, end_row, end_col = node:range()
  local lines = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
  return table.concat(lines, "\n"), start_row, end_row
end

---------------------------------------------------------------------------
-- SQL Content Extraction
---------------------------------------------------------------------------

-- Extract SQL from Tree-sitter by finding the nearest statement node
local function extract_sql_from_treesitter()
  if not is_treesitter_available() then
    return nil
  end

  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()

  if not node then
    return nil
  end

  -- Traverse up the AST to find a statement node
  while node do
    local node_type = node:type()
    if node_type:match("statement$") then
      return get_node_range_text(node)
    end
    node = node:parent()
  end

  return nil
end

-- Fallback: extract SQL from current paragraph boundaries
local function extract_sql_from_paragraph()
  local original_cursor = vim.api.nvim_win_get_cursor(0)

  -- Navigate to paragraph boundaries
  vim.cmd("silent! normal! {")
  local start_line = vim.api.nvim_win_get_cursor(0)[1]

  vim.cmd("silent! normal! }")
  local end_line_raw = vim.api.nvim_win_get_cursor(0)[1]

  -- Handle end-of-file case: if '}' didn't move us past the last line,
  -- we need to include the current line in the selection
  local total_lines = vim.api.nvim_buf_line_count(0)
  local end_line = (end_line_raw > original_cursor[1]) and (end_line_raw - 1) or total_lines

  -- Restore cursor position
  vim.api.nvim_win_set_cursor(0, original_cursor)

  -- Extract lines (convert to 0-indexed)
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  return table.concat(lines, "\n"), start_line - 1, end_line - 1
end

-- Main extraction function with fallback strategy
local function extract_sql_content()
  -- Try Tree-sitter first
  local content, start_row, end_row = extract_sql_from_treesitter()

  -- Fallback to paragraph extraction
  if not content then
    content, start_row, end_row = extract_sql_from_paragraph()
  end

  return vim.trim(content or ""), start_row, end_row
end

---------------------------------------------------------------------------
-- User Interaction
---------------------------------------------------------------------------

-- Function to create and show the SQL confirmation dialog
local function show_sql_confirmation(sql_query, callback)
  -- Store original window and buffer info
  local original_win = vim.api.nvim_get_current_win()
  local original_buf = vim.api.nvim_get_current_buf()

  -- Create popup for the SQL query with syntax highlighting
  local sql_popup = Popup({
    enter = false,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Execute the following SQL? ",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      wrap = false,
      scrolloff = 3,
    },
  })

  -- Create popup for the buttons
  local button_popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
  })

  -- Create layout
  local layout = Layout(
    {
      position = "50%",
      size = {
        width = "60%",
        height = "80%",
      },
    },
    Layout.Box({
      Layout.Box(sql_popup, { grow = 1 }),
      Layout.Box(button_popup, { size = 1 }),
    }, { dir = "col" })
  )

  -- Set SQL content with syntax highlighting
  vim.api.nvim_buf_set_lines(sql_popup.bufnr, 0, -1, false, vim.split(sql_query, "\n"))
  vim.api.nvim_buf_set_option(sql_popup.bufnr, "filetype", "sql")
  vim.api.nvim_buf_set_option(sql_popup.bufnr, "readonly", true)
  vim.api.nvim_buf_set_option(sql_popup.bufnr, "modifiable", false)

  -- Set button content
  local button_text = {
    "  [Y]es    [N]o    j/k: scroll    <C-u>/<C-d>: page up/down",
  }
  vim.api.nvim_buf_set_lines(button_popup.bufnr, 0, -1, false, button_text)
  vim.api.nvim_buf_set_option(button_popup.bufnr, "readonly", true)
  vim.api.nvim_buf_set_option(button_popup.bufnr, "modifiable", false)

  -- Function to close dialog and restore focus
  local function close_dialog()
    layout:unmount()
    -- Restore focus to original window and buffer
    if vim.api.nvim_win_is_valid(original_win) then
      vim.api.nvim_set_current_win(original_win)
    end
    if vim.api.nvim_buf_is_valid(original_buf) then
      vim.api.nvim_set_current_buf(original_buf)
    end
  end

  -- Set up keymaps for the button popup
  button_popup:map("n", "y", function()
    close_dialog()
    if callback then
      callback(true)
    end
  end, { noremap = true })

  button_popup:map("n", "Y", function()
    close_dialog()
    if callback then
      callback(true)
    end
  end, { noremap = true })

  button_popup:map("n", "n", function()
    close_dialog()
    if callback then
      callback(false)
    end
  end, { noremap = true })

  button_popup:map("n", "N", function()
    close_dialog()
    if callback then
      callback(false)
    end
  end, { noremap = true })

  button_popup:map("n", "<Esc>", function()
    close_dialog()
    if callback then
      callback(false)
    end
  end, { noremap = true })

  button_popup:map("n", "q", function()
    close_dialog()
    if callback then
      callback(false)
    end
  end, { noremap = true })

  -- Add keymaps for scrolling the SQL preview
  button_popup:map("n", "<C-u>", function()
    vim.api.nvim_win_call(sql_popup.winid, function()
      vim.cmd("normal! \\<C-u>")
    end)
  end, { noremap = true })

  button_popup:map("n", "<C-d>", function()
    vim.api.nvim_win_call(sql_popup.winid, function()
      vim.cmd("normal! \\<C-d>")
    end)
  end, { noremap = true })

  button_popup:map("n", "k", function()
    vim.api.nvim_win_call(sql_popup.winid, function()
      vim.cmd("normal! k")
    end)
  end, { noremap = true })

  button_popup:map("n", "j", function()
    vim.api.nvim_win_call(sql_popup.winid, function()
      vim.cmd("normal! j")
    end)
  end, { noremap = true })

  button_popup:map("n", "gg", function()
    vim.api.nvim_win_call(sql_popup.winid, function()
      vim.cmd("normal! gg")
    end)
  end, { noremap = true })

  button_popup:map("n", "G", function()
    vim.api.nvim_win_call(sql_popup.winid, function()
      vim.cmd("normal! G")
    end)
  end, { noremap = true })

  -- Mount the layout
  layout:mount()

  -- Set cursor position in button popup
  vim.api.nvim_win_set_cursor(button_popup.winid, { 1, 2 })
end

---------------------------------------------------------------------------
-- Execution Logic
---------------------------------------------------------------------------

local function execute_range(start_row, end_row)
  -- Add a small delay to ensure focus is properly restored
  vim.defer_fn(function()
    -- Navigate to start line, enter line-wise visual mode, then select to end line
    -- Format: {start_line}GV{end_line}G (converts 0-indexed to 1-indexed line numbers)
    local keys = string.format("%dGV%dG", start_row + 1, end_row + 1)

    -- Send the selection keys in normal mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", false)

    -- Execute the selected SQL query using DBUI plugin
    local execute_keys = vim.api.nvim_replace_termcodes("<Plug>(DBUI_ExecuteQuery)", true, false, true)

    -- Send execute command in visual mode (since we're now in visual selection)
    vim.api.nvim_feedkeys(execute_keys, "x", false)
  end, 10) -- 10ms delay to ensure proper focus restoration
end

---------------------------------------------------------------------------
-- Public API
---------------------------------------------------------------------------

-- Execute SQL statement under cursor (with Tree-sitter/paragraph fallback)
M.execute_sql_at_cursor = function()
  -- Validate dependencies
  if not is_dadbod_ui_available() then
    vim.notify("vim-dadbod-ui is not available", vim.log.levels.ERROR)
    return
  end

  -- Extract SQL content
  local content, start_row, end_row = extract_sql_content()

  if content == "" then
    vim.notify("No SQL content found near cursor", vim.log.levels.WARN)
    return
  end

  -- Confirm execution with user
  show_sql_confirmation(content, function(confirmed)
    if confirmed then
      -- Execute the query
      execute_range(start_row, end_row)
      vim.notify("SQL query executed", vim.log.levels.INFO)
    else
      vim.notify("SQL execution cancelled", vim.log.levels.INFO)
    end
  end)
end

-- Configuration function
M.setup = function(opts)
  if opts then
    config = vim.tbl_extend("force", config, opts)
  end
end

return M
