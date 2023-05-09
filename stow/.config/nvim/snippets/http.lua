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

return {
	s(
		"gql",
		fmt(
			[[
POST https://{}
Content-Type: application/json

{{
  "operationName": "{}",
  "query": "{}"
}}
]],
			{
        i(1), -- url
        i(2), -- operation name
        i(3), -- query
      }
		)
	),
}
