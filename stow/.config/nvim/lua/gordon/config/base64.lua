local base64 = require("gordon.lib.base64")

base64.setup()

vim.keymap.set("x", "<leader>be", function()
  base64.encode_visual_selection()
end, {
  desc = "Encode visual selection to base64",
})

vim.keymap.set("x", "<leader>bd", function()
  base64.decode_visual_selection()
end, {
  desc = "Decode visual selection to base64",
})

vim.keymap.set("n", "<leader>bc", function()
  base64.clear_diagnostic()
end, {
  desc = "Clear base64 diagnostics",
})
