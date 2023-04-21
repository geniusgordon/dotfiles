local ls = require('luasnip')

return {
    ls.parser.parse_snippet('fc', [[
import React from 'react'

function ${1:Component}({}: ${1:Component}Props): JSX.Element {
}

type ${1:Component}Props = {
}

export default ${1:Component}
  ]]),
}
