vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- "_ is the black hole register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- "+ is the register corresponds to the system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- <C-r><C-w> inserts the word under the cursor surrounded by word boundaries
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>'", "vi[:s/\\(\\w\\+\\)/'\\1',/")

vim.keymap.set("n", "<leader>/", ":set hlsearch! hlsearch?<CR>")
vim.keymap.set("n", "<leader>v", ":set paste! paste?<CR>")

-- prints the highlight group under the cursor
vim.keymap.set("n", "<F10>", function ()
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local hi = vim.fn.synIDattr(vim.fn.synID(line, col , 1), "name")
  local trans = vim.fn.synIDattr(vim.fn.synID(line, col , 0), "name")
  local lo = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(line, col , 1)), "name")
  print("hi<" .. hi .. "> trans<" .. trans .. "> lo<" .. lo .. ">")
end)

