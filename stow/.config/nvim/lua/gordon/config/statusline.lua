local colors = require("gordon.lib.theme.catppuccin").colors

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      "diff",
    },
    lualine_c = {
      "filename",
      "location",
      "progress",
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols = { error = " ", warn = " ", hint = " ", info = " " },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      },
      {
        "filetype",
        icon = { align = "left" },
      },
    },
    lualine_y = { "encoding" },
    lualine_z = {
      function()
        local client_names = {}
        for _, client in ipairs(vim.lsp.get_clients()) do
          table.insert(client_names, client.name)
        end

        if vim.o.columns < 100 then
          return ""
        end

        if #client_names == 0 then
          return ""
        end

        return "  " .. table.concat(client_names, " ")
      end,
    },
  },
  inactive_sections = {},
  -- tabline = {
  --   lualine_a = {
  --     {
  --       "tabs",
  --       tab_max_length = 40, -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
  --       max_length = vim.o.columns / 3, -- Maximum width of tabs component.
  --       -- Note:
  --       -- It can also be a function that returns
  --       -- the value of `max_length` dynamically.
  --       mode = 1, -- 0: Shows tab_nr
  --       -- 1: Shows tab_name
  --       -- 2: Shows tab_nr + tab_name
  --
  --       path = 0, -- 0: just shows the filename
  --       -- 1: shows the relative path and shorten $HOME to ~
  --       -- 2: shows the full path
  --       -- 3: shows the full path and shorten $HOME to ~
  --
  --       -- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
  --       use_mode_colors = false,
  --       show_modified_status = false, -- Shows a symbol next to the tab name if the file has been modified.
  --       fmt = function(name, context)
  --         -- Show + if buffer is modified in tab
  --         local buflist = vim.fn.tabpagebuflist(context.tabnr)
  --         local winnr = vim.fn.tabpagewinnr(context.tabnr)
  --         local bufnr = buflist[winnr]
  --         local mod = vim.fn.getbufvar(bufnr, "&mod")
  --
  --         return name .. (mod == 1 and " [+]" or "")
  --       end,
  --     },
  --   },
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = {},
  -- },
  winbar = {},
  inactive_winbar = {},
  extensions = {
    "fugitive",
    "lazy",
    "mason",
    "nvim-tree",
    "oil",
    "quickfix",
  },
})
