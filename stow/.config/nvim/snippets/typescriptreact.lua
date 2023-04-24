local ls = require('luasnip')

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
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
import React from 'react';

function {}({{
{}
}}: {}Props): {} {{
}}

type {}Props = {{
{}
}}

export default {}
]], {
      i(1),     -- name
      props(3), -- props fields
      same(1),  -- props type
      c(2, { t('JSX.Element'), t('JSX.Element | null') }), -- return type
      same(1),  -- props type
      i(3),     -- props type fields
      same(1),  -- export
    })
  ),
}
