vim.g.mapleader = " "

local function is_quickfix_open()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      return true
    end
  end
  return false
end

local wk = require("which-key")
wk.add({
  {
    mode = { "v" },
    { "J", ":m '>+1<CR>gv=gv" },
    { "K", ":m '<-2<CR>gv=gv" },
    { "<leader>y", [["+y]], desc = "Yank to system clipboard" },
  },
  {
    mode = { "n" },
    { "J", "mzJ`z" },
    { "<C-d>", "<C-d>zz" },
    { "<C-u>", "<C-u>zz" },
    { "n", "nzzzv" },
    { "N", "Nzzzv" },
    { "<leader>y", [["+y]], desc = "Yank to system clipboard" },
    { "<leader>Y", [["+Y]], desc = "Yank to system clipboard" },
    { "<leader>X", [["_d]], desc = "Delete to black hole" },
    { "<leader>j", "<cmd>cnext<CR>zz", desc = "Next quickfix" },
    { "<leader>k", "<cmd>cprev<CR>zz", desc = "Previous quickfix" },
    {
      "<leader>cp",
      function()
        local path = vim.fn.expand("%")
        if path == "" then
          vim.notify("No file path to copy", vim.log.levels.WARN)
          return
        end
        vim.fn.setreg("+", path)
        vim.notify("Copied relative file path to clipboard", vim.log.levels.INFO)
      end,
      desc = "Copy relative file path to clipboard",
    },
    { "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Replace word under cursor" },
    { "<leader>['", "vi[:s/\\(\\w\\+\\)/'\\1',/", desc = "Add quotes around []" },
    { "<leader>('", "vi(:s/\\(\\w\\+\\)/'\\1',/", desc = "Add quotes around ()" },
    { "<leader>/", ":set hlsearch! hlsearch?<CR>", desc = "Toggle search highlighting" },
    { "<leader>v", ":set paste! paste?<CR>", desc = "Toggle paste mode" },
    {
      "<F10>",
      function()
        local line = vim.fn.line(".")
        local col = vim.fn.col(".")
        local hi = vim.fn.synIDattr(vim.fn.synID(line, col, 1), "name")
        local trans = vim.fn.synIDattr(vim.fn.synID(line, col, 0), "name")
        local lo = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(line, col, 1)), "name")
        print("hi<" .. hi .. "> trans<" .. trans .. "> lo<" .. lo .. ">")
      end,
      desc = "Print highlight group",
    },
    {
      "<leader>q",
      function()
        if is_quickfix_open() then
          vim.cmd("cclose")
        else
          vim.cmd("botright copen")
        end
      end,
      desc = "Toggle quickfix list",
    },
    { "<leader>tv", "<cmd>botright split | terminal<CR>", desc = "Open terminal in horizontal split" },
    { "<leader>ts", "<cmd>botright vsplit | terminal<CR>", desc = "Open terminal in vertical split" },
    { "<leader>te", "<cmd>tabe<CR>", desc = "Open new tab" },
  },
  {
    mode = { "x" },
    { "<leader>p", [["_dP]] },
  },
  {
    mode = { "c" },
    { "<C-a>", "<Home>", silent = false },
    { "<C-f>", "<Right>", silent = false },
    { "<C-d>", "<Left>", silent = false },
  },
  {
    mode = { "t" },
    { "<Esc>", "<C-\\><C-n>", silent = false, desc = "Exit terminal mode" },
  },
})
