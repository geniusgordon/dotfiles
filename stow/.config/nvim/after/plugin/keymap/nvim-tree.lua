print('nvim-tree')

local api = require('nvim-tree.api')
local Remap = require("gordon.keymap")
local nnoremap = Remap.nnoremap

nnoremap('<leader>tt', ':NvimTreeToggle<CR>')
nnoremap('<leader>tf', ':NvimTreeFindFile<CR>')
