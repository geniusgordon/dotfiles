local function setup_catppuccin_mocha()
  require("catppuccin").setup({
    flavour = "mocha",
  })
  local colors = require("gordon.lib.theme.catppuccin").colors

  return {
    colorscheme = "catppuccin-mocha",
    colors = colors,
  }
end

local function setup_tokyonight()
  local colors = require("gordon.lib.theme.tokyonight").colors
  return {
    colorscheme = "tokyonight-night",
    colors = colors,
  }
end

local function setup_kanagawa_dragon()
  require("kanagawa").setup({
    theme = "dragon",
  })
  local colors = require("gordon.lib.theme.kanagawa").colors
  return {
    colorscheme = "kanagawa-dragon",
    colors = colors,
    override = function()
      vim.g.terminal_color_8 = colors.fg_light
      vim.api.nvim_set_hl(0, "Comment", { fg = colors.fg_light })
    end,
  }
end

---@class Theme
---@field colorscheme string
---@field colors ColorPalette
---@field override function | nil
---@param theme "tokyonight" | "catppuccin-mocha" | "kanagawa-dragon"
---@return Theme
local function setup_theme(theme)
  if theme == "tokyonight" then
    return setup_tokyonight()
  elseif theme == "kanagawa-dragon" then
    return setup_kanagawa_dragon()
  end
  return setup_catppuccin_mocha()
end

local function setup_highlights(colors)
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.fg_light })
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.fg_light })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.magenta })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.bg_cursor_line })
  vim.api.nvim_set_hl(0, "Visual", { bg = colors.bg_visual })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = colors.bg })

  vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.bg })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.line })
  vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "CmpItemAbbr", italic = true })
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = colors.green })

  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.fg_light })
  vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = colors.red })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.red })

  vim.api.nvim_set_hl(0, "IblIndent", { fg = colors.line })
  vim.api.nvim_set_hl(0, "IblWhitespace", { fg = colors.line })
  vim.api.nvim_set_hl(0, "IblScope", { fg = colors.line })

  vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = colors.line })

  vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.line })
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colors.bg })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = colors.bg })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.line })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.bg, bg = colors.red })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = colors.bg, bg = colors.green })
  vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colors.bg, bg = colors.blue })
  vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = colors.red, bg = colors.bg })

  vim.api.nvim_set_hl(0, "TreesitterContext", { bg = colors.bg_visual })
  vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = false })

  vim.api.nvim_set_hl(0, "OutlineFoldMarker", { link = "NvimTreeIndentMarker" })
end

local theme_env = vim.env.THEME or "tokyonight"
local theme = setup_theme(theme_env)

local setup = function()
  vim.cmd.colorscheme(theme.colorscheme)
  setup_highlights(theme.colors)
  if theme.override then
    theme.override()
  end
end

local M = {
  setup = setup,
  theme = theme,
}

return M
