local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s({
    trig = "ct",
    name = "Content-Type",
  }, {
    t("Content-Type: "),
    c(1, {
      t("application/json"),
      t("application/x-www-form-urlencoded"),
      t("multipart/form-data"),
    }),
  }),
  s(
    {
      trig = "gql",
      name = "GraphQL",
    },
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
