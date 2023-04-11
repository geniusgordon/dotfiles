require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = "catppuccin",
    component_separators = { left = '', right = '|' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        sources = { 'coc' },
        sections = { 'error', 'warn', 'info', 'hint' },
        diagnostics_color = {
          error = 'DiagnosticError',
          warn  = 'DiagnosticWarn',
          info  = 'DiagnosticInfo',
          hint  = 'DiagnosticHint',
        },
        symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      }
    },
    lualine_c = {
      {
        'filetype',
        icon_only = true,
        icon = { align = 'right' },
      },
      'filename',
    },
    lualine_x = { 'fileformat' },
    lualine_y = { 'encoding' },
    lualine_z = { 'progress' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
