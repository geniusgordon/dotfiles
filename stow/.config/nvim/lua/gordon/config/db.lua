vim.g.db_ui_use_nerd_fonts = true
vim.g.db_ui_execute_on_save = false

local sql_exec = require("gordon.lib.db.sql-exec")

vim.keymap.set("n", "<leader>dg", ":tabnew | DBUIToggle<CR>", {
  noremap = true,
  silent = true,
  desc = "Toggle DBUI",
})

-- DBUI-specific keymaps using autocommand
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dbui", "sql" }, -- DBUI uses these filetypes
  callback = function()
    -- Only set keymap in DBUI buffers
    vim.keymap.set("n", "<leader>S", sql_exec.execute_sql_at_cursor, {
      buffer = true, -- buffer-local keymap
      noremap = true,
      silent = true,
      desc = "Execute SQL paragraph with confirmation",
    })
  end,
})
