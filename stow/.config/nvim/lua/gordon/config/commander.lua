local encoding = require("gordon.lib.encoding")
local fileformat = require("gordon.lib.fileformat")
local csv = require("gordon.lib.csv")

require("commander").add({
  {
    desc = "Open commander",
    cmd = require("commander").show,
    keys = { "n", "<C-I>" },
  },
  {
    desc = "Open file with encoding",
    cmd = encoding.open_with_encoding,
  },
  {
    desc = "Save file with encoding",
    cmd = encoding.save_with_encoding
  },
  {
    desc = "Set file format",
    cmd = fileformat.set_fileformat,
  },
  {
    desc = "Arrange CSV Column",
    cmd = csv.arrange_column,
  },
  {
    desc = "Unarrange CSV Column",
    cmd = csv.unarrange_column,
  },
})
