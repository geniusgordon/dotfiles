local Remap = require("gordon.keymap")
local nnoremap = Remap.nnoremap

nnoremap('<leader>dv', ':DiffviewOpen<CR>')
nnoremap('<leader>dc', ':DiffviewClose<CR>')
nnoremap('<leader>dt', ':DiffviewToggleFiles<CR>')
