local M = {}

function M.setup()
  require("tailwind-tools").setup({
    document_color = {
      enabled = true,
      kind = "inline",
      inline_symbol = "██ ",
      debounce = 200,
    },
    conceal = {
      enabled = true,
      min_length = 60,
      symbol = "󱏿",
      highlight = {
        fg = "#38BDF8",
      },
    },
    cmp = {
      highlight = "foreground", -- color preview style, "foreground" | "background"
    },
    custom_filetypes = {},
  })
end

return M
