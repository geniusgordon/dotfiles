local Remap = require("gordon.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<Leader>ff", function()
    require('telescope.builtin').find_files()
end)
nnoremap("<leader>fg", function()
    require('telescope.builtin').git_files()
end)
nnoremap("<leader>fs", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end)
nnoremap("<leader>fw", function()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }
end)
nnoremap("<leader>fb", function()
    require('telescope.builtin').buffers()
end)
nnoremap("<leader>fh", function()
    require('telescope.builtin').help_tags()
end)
