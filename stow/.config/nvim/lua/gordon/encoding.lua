local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local encoding = function(opts)
  opts = opts or {}
  local action = opts.action or function(_) end

  pickers.new(opts, {
    prompt_title = "Encoding",
    finder = finders.new_table({
      results = {
        { '1', 'latin1',       '8-bit characters (iso 8859-1, also used for cp1252)' },
        { '1', 'iso-8859-n',   'iso_8859 variant (n = 2 to 15)' },
        { '1', 'koi8-r',       'russian' },
        { '1', 'koi8-u',       'ukrainian' },
        { '1', 'macroman',     'macroman (macintosh encoding)' },
        { '1', '8bit-{name}',  'any 8-bit encoding (vim specific name)' },
        { '1', 'cp437',        'similar to iso-8859-1' },
        { '1', 'cp737',        'similar to iso-8859-7' },
        { '1', 'cp775',        'baltic' },
        { '1', 'cp850',        'similar to iso-8859-4' },
        { '1', 'cp852',        'similar to iso-8859-1' },
        { '1', 'cp855',        'similar to iso-8859-2' },
        { '1', 'cp857',        'similar to iso-8859-5' },
        { '1', 'cp860',        'similar to iso-8859-9' },
        { '1', 'cp861',        'similar to iso-8859-1' },
        { '1', 'cp862',        'similar to iso-8859-1' },
        { '1', 'cp863',        'similar to iso-8859-8' },
        { '1', 'cp865',        'similar to iso-8859-1' },
        { '1', 'cp866',        'similar to iso-8859-5' },
        { '1', 'cp869',        'similar to iso-8859-7' },
        { '1', 'cp874',        'thai' },
        { '1', 'cp1250',       'czech, polish, etc.' },
        { '1', 'cp1251',       'cyrillic' },
        { '1', 'cp1253',       'greek' },
        { '1', 'cp1254',       'turkish' },
        { '1', 'cp1255',       'hebrew' },
        { '1', 'cp1256',       'arabic' },
        { '1', 'cp1257',       'baltic' },
        { '1', 'cp1258',       'vietnamese' },
        { '1', 'cp{number}',   'ms-windows: any installed single-byte codepage' },
        { '2', 'cp932',        'japanese (windows only)' },
        { '2', 'euc-jp',       'japanese' },
        { '2', 'sjis',         'japanese' },
        { '2', 'cp949',        'korean' },
        { '2', 'euc-kr',       'korean' },
        { '2', 'cp936',        'simplified chinese (windows only)' },
        { '2', 'euc-cn',       'simplified chinese' },
        { '2', 'cp950',        'traditional chinese (alias for big5)' },
        { '2', 'big5',         'traditional chinese (alias for cp950)' },
        { '2', 'euc-tw',       'traditional chinese' },
        { '2', '2byte-{name}', 'any double-byte encoding (vim-specific name)' },
        { '2', 'cp{number}',   'ms-windows: any installed double-byte codepage' },
        { 'u', 'utf-8',        '32 bit utf-8 encoded unicode (iso/iec 10646-1)' },
        { 'u', 'ucs-2',        '16 bit ucs-2 encoded unicode (iso/iec 10646-1)' },
        { 'u', 'ucs-2le',      'like ucs-2, little endian' },
        { 'u', 'utf-16',       'ucs-2 extended with double-words for more characters' },
        { 'u', 'utf-16le',     'like utf-16, little endian' },
        { 'u', 'ucs-4',        '32 bit ucs-4 encoded unicode (iso/iec 10646-1)' },
        { 'u', 'ucs-4le',      'like ucs-4, little endian' },
      },
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[1] .. ' ' .. entry[2] .. '' .. string.rep(' ', 12 - #entry[2]) .. ' ' .. entry[3],
          ordinal = entry[2],
        }
      end
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        action(selection)
      end)
      return true
    end,
  }):find()
end

local M = {}

M.open_with_encoding = function()
  encoding {
    prompt_title = "encoding",
    action = function(selection)
      vim.cmd('e ++enc=' .. selection.value[2])
    end
  }
end

M.save_with_encoding = function()
  encoding {
    prompt_title = "encoding",
    action = function(selection)
      vim.cmd('w ++enc=' .. selection.value[2])
    end
  }
end

return M
