local ls = require('luasnip')
local f = ls.function_node
local ai = require("luasnip.nodes.absolute_indexer")

local M = {}

M.same = function(index)
  return f(function(args)
    return args[1]
  end, ai[index])
end

M.type_to_obj = function(arg)
  local result = {}
  for _, value in ipairs(arg) do
    local name = string.match(value, "^%s*(%a+)")

    if name ~= nil then
      name = string.gsub(name, "%s", "")
      name = string.gsub(name, "\t", "")
      table.insert(result, "\t" .. name .. ",")
    end
  end

  return result
end

return M
