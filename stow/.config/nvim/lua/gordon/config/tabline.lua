local bufferline = require("bufferline")
bufferline.setup({
  options = {
    style_preset = bufferline.style_preset.minimal,
    separator_style = "thin",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "Explorer",
        highlight = "Directory",
        separator = true,
      },
    },
  },
})
