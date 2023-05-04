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

return {
  s("pr", t("private readonly")),
  s(
    {
      trig = "uq",
      name = "useQuery",
      dscr = "Create a useQuery hook",
    },
    fmt(
      [[
export function use{}({}) {{
  return useQuery<
    {}Data,
    {}
  >({}{})
}}

type {}Data = {{
  {}
}}

{}
]],
      {
        i(1),    -- hook name
        i(2),    -- args
        same(1), -- data type
        c(3, {
          t(""),
          sn(nil, { same(1), t("Variables"), i(1) }),
        }),      -- variables type choice
        same(1), -- gql
        d(4, function(args)
          if args[1][1] == "" then
            return sn(nil, { t("") })
          end
          return sn(
            nil,
            fmt(
              [[, {{
  variables: {{
    {}
  }}
}}]],
              { i(1) }
            )
          )
        end, ai[3]), -- variables args
        same(1),     -- data type
        i(5),        -- data type fields
        d(6, function(args)
          if args[1][1] == "" then
            return sn(nil, { t("") })
          end
          return sn(
            nil,
            fmt(
              [[
type {}Variables = {{
  {}
}}
        ]],
              {
                same(1),
                i(1),
              }
            )
          )
        end, ai[3]), -- variables type
      }
    )
  ),
  s(
    {
      trig = "um",
      name = "useMutation",
      dscr = "Create a useMutation hook",
    },
    fmt(
      [[
export function use{}({}) {{
  const fn = useMutation<
    {}Data,
    {}
  >({})

  const {} = React.useCallback(() => {{
    return fn({})
  }}, [fn])

  return {}
}}

type {}Data = {{
  {}
}}

{}
]],
      {
        i(1),    -- hook name
        i(2),    -- args
        same(1), -- data type
        c(3, {
          t(""),
          sn(nil, { same(1), t("Variables"), i(1) }),
        }),      -- variables type choice
        same(1), -- gql
        f(function(args)
          local str = args[1][1]
          return string.lower(string.sub(str, 1, 1)) .. string.sub(str, 2)
        end, { 1 }),
        d(4, function(args)
          if args[1][1] == "" then
            return sn(nil, { t("") })
          end

          -- TODO type_to_obj
          return sn(
            nil,
            fmt(
              [[{{
      variables: {{
        {}
      }}
    }}]],
              { i(1) }
            )
          )
        end, ai[3]), -- variables args
        f(function(args)
          local str = args[1][1]
          return string.lower(string.sub(str, 1, 1)) .. string.sub(str, 2)
        end, { 1 }),
        same(1), -- data type
        i(5),    -- data type fields
        d(6, function(args)
          if args[1][1] == "" then
            return sn(nil, { t("") })
          end
          return sn(
            nil,
            fmt(
              [[
          type {}Variables = {{
            {}
          }}]],
              {
                same(1),
                i(1),
              }
            )
          )
        end, ai[3]), -- variables type
      }
    )
  ),
}
