local Remap = require("gordon.keymap")
local inoremap = Remap.inoremap

inoremap("<C-j>", "<Plug>(copilot-next)")
inoremap("<C-k>", "<Plug>(copilot-previous)")
inoremap("<C-l>", "<Plug>(copilot-suggest)")
