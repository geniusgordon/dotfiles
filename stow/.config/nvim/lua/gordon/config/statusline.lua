require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "tokyonight",
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
      {
        "filetype",
        icon_only = true,
        icon = { align = "right" },
        padding = { left = 1, right = 0 },
      },
      "filename",
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
      "fileformat",
    },
    lualine_y = { "encoding" },
    lualine_z = { "progress" },
  },
  inactive_sections = {},
  tabline = {},
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
