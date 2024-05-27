local encoding = require("gordon.encoding")
local fileformat = require("gordon.fileformat")

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
})
