local ls = require('luasnip')

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt
local same = require('gordon.snippet').same

local function props(index)
  return f(function(args)
    local result = {}
    for _, value in ipairs(args[1]) do
      local name = string.match(value, "^%s*(%a+)")

      if name ~= nil then
        name = string.gsub(name, "%s", "")
        name = string.gsub(name, "\t", "")
        table.insert(result, "\t" .. name .. ",")
      end
    end

    print(vim.inspect(result))

    return result
  end, { index })
end

return {
  s('fc',
    fmt([[
function {}({{
{}
}}: {}Props): JSX.Element {{
}}

type {}Props = {{
{}
}}

export default {}
]], {
      i(1),     -- name
      props(2), -- props fields
      same(1),  -- props type
      same(1),  -- props type
      i(2),     -- props type fields
      same(1),  -- export
    })
  ),
}
