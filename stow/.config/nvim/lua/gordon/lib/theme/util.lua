---@class ColorPalette
---@field none "NONE"
---@field bg string
---@field fg string
---@field fg_light string
---@field bg_light string
---@field bg_visual string
---@field bg_cursor_line string
---@field line string
---@field line_dark string
---@field red string Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
---@field orange string Integers, Boolean, Constants, XML Attributes, Markup Link Url
---@field yellow string Classes, Markup Bold, Search Text Background
---@field green string Strings, Inherited Class, Markup Code, Diff Inserted
---@field cyan string Support, Regular Expressions, Escape Characters, Markup Quotes
---@field blue string Functions, Methods, Attribute IDs, Headings
---@field magenta string Keywords, Storage, Selector, Markup Italic, Diff Changed
---@param colors ColorPalette
---@return ColorPalette
local function createColorPalatte(colors)
  return colors
end

local M = {
  createColorPalatte = createColorPalatte,
}

return M
