local function setup_catppuccin_mocha()
  require("catppuccin").setup({
    flavour = "mocha",
    color_overrides = {
      mocha = {
        base = "#000000",
        mantle = "#000000",
        crust = "#000000",
      },
    },
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

---@param colors ColorPalette
local function setup_highlights(colors)
  vim.api.nvim_set_hl(0, "Normal", { bg = colors.bg })
  -- vim.api.nvim_set_hl(0, "WinSeparator", { fg = colors.line_dark })
  --
  vim.api.nvim_set_hl(0, "Sidebar", { bg = colors.bg_light })
  vim.api.nvim_set_hl(0, "BottomPanel", { bg = colors.bg_light })

  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.fg_light })
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors.red })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.fg_light })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.magenta })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.bg_cursor_line })
  vim.api.nvim_set_hl(0, "Visual", { bg = colors.bg_visual })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = colors.bg })
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = colors.bg_light })
  vim.api.nvim_set_hl(0, "qfLineNr", { fg = colors.red })

  vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.bg })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.line, bg = colors.bg })
  vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "CmpItemAbbr", italic = true })
  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = colors.green })

  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.fg_light })
  vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = colors.red })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.red })

  vim.api.nvim_set_hl(0, "IblIndent", { fg = colors.line })
  vim.api.nvim_set_hl(0, "IblWhitespace", { fg = colors.line })
  vim.api.nvim_set_hl(0, "IblScope", { fg = colors.line })
  vim.api.nvim_set_hl(0, "@ibl.scope.char.1", { fg = colors.line_dark })

  vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = colors.line })
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { link = "Sidebar" })

  vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colors.bg })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = colors.bg })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "FloatBorder" })
  vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.bg, bg = colors.red })
  vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = colors.bg, bg = colors.green })
  vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colors.bg, bg = colors.blue })
  vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = colors.red, bg = colors.bg })

  vim.api.nvim_set_hl(0, "TreesitterContext", { bg = colors.bg_visual })
  vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = false })

  vim.api.nvim_set_hl(0, "OutlineFoldMarker", { link = "NvimTreeIndentMarker" })
  vim.api.nvim_set_hl(0, "WhichKeyNormal", { link = "NvimTreeNormal" })

  vim.api.nvim_set_hl(0, "FoldedText", { link = "Visual" })

  vim.api.nvim_set_hl(0, "TermNormal", { link = "BottomPanel" })
  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
      vim.opt_local.winhighlight = "Normal:TermNormal,SignColumn:TermNormal"
    end,
  })

  local function apply_qf_highlight()
    vim.api.nvim_set_hl(0, "QuickFixNormal", { link = "BottomPanel" }) -- background
    -- vim.api.nvim_set_hl(0, "QuickFixBorder", {}) -- optional

    -- Redirect highlights just for this window
    vim.opt_local.winhighlight = table.concat({
      "Normal:QuickFixNormal",
      "NormalNC:QuickFixNormal",
      "SignColumn:QuickFixNormal",
      "EndOfBuffer:QuickFixNormal",
      -- Uncomment if you drew borders with `set winblend` or a plugin:
      -- "VertSplit:QuickFixBorder",
    }, ",")
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = apply_qf_highlight,
  })

  vim.api.nvim_set_hl(0, "DBUISidebar", { link = "Sidebar" })
  vim.api.nvim_set_hl(0, "DBUIResult", { link = "BottomPanel" })
  local function apply_dbui_highlight(event)
    if event.match == "dbui" then
      vim.opt_local.winhighlight = table.concat({
        "Normal:DBUISidebar",
        "NormalNC:DBUISidebar",
        "SignColumn:DBUISidebar",
        "EndOfBuffer:DBUISidebar",
      }, ",")
    elseif event.match == "dbout" then
      vim.opt_local.winhighlight = table.concat({
        "Normal:DBUIResult",
        "NormalNC:DBUIResult",
        "SignColumn:DBUIResult",
        "EndOfBuffer:DBUIResult",
      }, ",")
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "dbui", "dbout" },
    callback = apply_dbui_highlight,
  })
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
