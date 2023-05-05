local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local same = require("gordon.snippet").same
local type_to_obj = require("gordon.snippet").type_to_obj
local ai = require("luasnip.nodes.absolute_indexer")

local function props(index)
	return f(function(args)
		return type_to_obj(args[1])
	end, ai[index])
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

function {}({}): {} {{
}}

{}

export default {}
]],
			{
				i(1), -- name
				d(2, function(args)
					if args[1][1] == "" then
						return sn(nil, { t("") })
					end
					return sn(
						nil,
						fmt(
							[[{{
  {}
}}]],
							{
								f(function(a)
									return type_to_obj(a[1])
								end, ai[4][2][1]),
							}
						)
					)
				end, ai[4]),
				c(3, { t("JSX.Element"), t("JSX.Element | null") }), -- return type
				c(4, {
					t(""),
					sn(
						nil,
						fmt(
							[[
type {}Props = {{
  {}
}}
          ]],
							{
								same(1),
								i(1),
							}
						)
					),
				}),
				same(1), -- export
			}
		)
	),
}
