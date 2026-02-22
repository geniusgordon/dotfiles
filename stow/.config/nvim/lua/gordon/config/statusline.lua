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
    lualine_y = {
      {
        "encoding",
        cond = function()
          return (vim.bo.fileencoding or vim.o.encoding) ~= "utf-8"
        end,
      },
    },
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
