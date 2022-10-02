local Remap = require("gordon.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

nnoremap("<leader>pv", ":Ex<CR>")
nnoremap("<leader>u", ":UndotreeShow<CR>")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

nnoremap("Y", "yg$")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- This is going to get me cancelled
inoremap("<C-c>", "<Esc>")

nnoremap("Q", "<nop>")
nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
nnoremap("<leader>s'", "vi[:s/\\(\\w\\+\\)/'\\1',/")

nnoremap("<leader>/", ":set hlsearch! hlsearch?<CR>")
nnoremap("<leader>v", ":set paste! paste?<CR>")

nnoremap("<F10>", function ()
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local hi = vim.fn.synIDattr(vim.fn.synID(line, col , 1), "name")
  local trans = vim.fn.synIDattr(vim.fn.synID(line, col , 0), "name")
  local lo = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(line, col , 1)), "name")
  print("hi<" .. hi .. "> trans<" .. trans .. "> lo<" .. lo .. ">")
end)
