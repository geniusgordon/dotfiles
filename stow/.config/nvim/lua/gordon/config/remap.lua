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
        -- :.  makes the path relative to the current working directory
        local path = vim.fn.expand("%:.")

        if path == "" then
          vim.notify("No file path to copy", vim.log.levels.WARN)
          return
        end

        local result = path
        local mode = vim.fn.mode()

        -- Check if we're in visual mode
        local in_visual = mode == "v" or mode == "V" or mode == "\22"
        if in_visual then
          -- Get selection bounds while still in visual mode
          local line1 = vim.fn.line("v")
          local line2 = vim.fn.line(".")
          local start_line = math.min(line1, line2)
          local end_line = math.max(line1, line2)

          if start_line == end_line then
            result = path .. ":" .. start_line
          else
            result = path .. ":" .. start_line .. "-" .. end_line
          end
        end

        vim.fn.setreg("+", result)
        vim.notify("Copied: " .. result, vim.log.levels.INFO)

        if in_visual then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        end
      end,
      mode = { "n", "v" },
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
