vim.g.mapleader = " "

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
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>X", [["_d]], { desc = "Delete to black hole" })

vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz", { desc = "Next error" })
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz", { desc = "Previous error" })

-- <C-r><C-w> inserts the word under the cursor surrounded by word boundaries
vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor" }
)

vim.keymap.set("n", "<leader>'", "vi[:s/\\(\\w\\+\\)/'\\1',/", { desc = "Add quotes" })

vim.keymap.set("n", "<leader>/", ":set hlsearch! hlsearch?<CR>", { desc = "Toggle search highlighting" })

vim.keymap.set("n", "<leader>v", ":set paste! paste?<CR>", { desc = "Toggle paste mode" })

-- prints the highlight group under the cursor
vim.keymap.set("n", "<F10>", function()
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  local hi = vim.fn.synIDattr(vim.fn.synID(line, col, 1), "name")
  local trans = vim.fn.synIDattr(vim.fn.synID(line, col, 0), "name")
  local lo = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(line, col, 1)), "name")
  print("hi<" .. hi .. "> trans<" .. trans .. "> lo<" .. lo .. ">")
end, { desc = "Print highlight group" })

local function is_quickfix_open()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      return true
    end
  end
  return false
end

vim.keymap.set("n", "<leader>q", function()
  if is_quickfix_open() then
    vim.cmd("cclose")
  else
    vim.cmd("botright copen")
  end
end, { desc = "Toggle quickfix list" })

vim.keymap.set("c", "<C-a>", "<Home>", { silent = false })
vim.keymap.set("c", "<C-f>", "<Right>", { silent = false })
vim.keymap.set("c", "<C-d>", "<Left>", { silent = false })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = false, desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>tv", "<cmd>botright split | terminal<CR>", { desc = "Open terminal in horizontal split" })
vim.keymap.set("n", "<leader>ts", "<cmd>botright vsplit | terminal<CR>", { desc = "Open terminal in vertical split" })

vim.keymap.set("n", "<leader>te", "<cmd>tabe<CR>", { desc = "Open new tab" })
