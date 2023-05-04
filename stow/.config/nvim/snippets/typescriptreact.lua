local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local same = require("gordon.snippet").same
local type_to_obj = require("gordon.snippet").type_to_obj

local function props(index)
  return f(function(args)
    return type_to_obj(args[1])
  end, { index })
end

return {
  s(
    {
      trig = "fc",
      name = "Functional Component",
      dscr = "Create a functional component",
    },
    fmt(
      [[
import React from 'react';

function {}({{
{}
}}: {}Props): {} {{
}}

type {}Props = {{
  {}
}}

export default {}
]],
      {
        i(1),                                                -- name
        props(3),                                            -- props fields
        same(1),                                             -- props type
        c(2, { t("JSX.Element"), t("JSX.Element | null") }), -- return type
        same(1),                                             -- props type
        i(3),                                                -- props type fields
        same(1),                                             -- export
      }
    )
  ),
}
