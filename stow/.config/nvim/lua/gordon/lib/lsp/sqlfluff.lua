local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local setup_null_ls = require("gordon.lib.lsp.lsp").setup_null_ls

local M = {}

M.update_sqlfluff_dialect = function()
  pickers
    .new({}, {
      prompt_title = "File Format",
      finder = finders.new_table({
        results = {
          { "ansi", "ansi dialect [inherits from 'nothing']" },
          { "athena", "athena dialect [inherits from 'ansi']" },
          { "bigquery", "bigquery dialect [inherits from 'ansi']" },
          { "clickhouse", "clickhouse dialect [inherits from 'ansi']" },
          { "databricks", "databricks dialect [inherits from 'sparksql']" },
          { "db2", "db2 dialect [inherits from 'ansi']" },
          { "duckdb", "duckdb dialect [inherits from 'postgres']" },
          { "exasol", "exasol dialect [inherits from 'ansi']" },
          { "greenplum", "greenplum dialect [inherits from 'postgres']" },
          { "hive", "hive dialect [inherits from 'ansi']" },
          { "materialize", "materialize dialect [inherits from 'postgres']" },
          { "mysql", "mysql dialect [inherits from 'ansi']" },
          { "oracle", "oracle dialect [inherits from 'ansi']" },
          { "postgres", "postgres dialect [inherits from 'ansi']" },
          { "redshift", "redshift dialect [inherits from 'postgres']" },
          { "snowflake", "snowflake dialect [inherits from 'ansi']" },
          { "soql", "soql dialect [inherits from 'ansi']" },
          { "sparksql", "sparksql dialect [inherits from 'ansi']" },
          { "sqlite", "sqlite dialect [inherits from 'ansi']" },
          { "teradata", "teradata dialect [inherits from 'ansi']" },
          { "trino", "trino dialect [inherits from 'ansi']" },
          { "tsql", "tsql dialect [inherits from 'ansi']" },
          { "vertica", "vertica dialect [inherits from 'ansi']" },
        },
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry[1] .. "" .. string.rep(" ", 12 - #entry[1]) .. " " .. entry[2],
            ordinal = entry[1],
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          print("Update SQLFluff dialect: " .. selection.value[1])
          setup_null_ls({ sqlfluff_dialect = selection.value[1] })
        end)
        return true
      end,
    })
    :find()
end

return M
