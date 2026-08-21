local autocmd = vim.api.nvim_create_autocmd

vim.filetype.add({
  extension = {
    conf = "ini", -- 將 .conf 檔當作 ini 處理
  },
})

autocmd("FileType", {
  pattern = "make",
  command = "setlocal noexpandtab",
})

autocmd("BufReadPost", {
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})

autocmd("FileType", {
  pattern = { "xml", "csv", "dbout", "qf", "markdown" },
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})

autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.commentstring = "// %s"
  end,
})

autocmd("FileType", {
  pattern = { "terraform" },
  callback = function()
    vim.opt_local.commentstring = "# %s"
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.http",
  command = "setlocal filetype=http",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".env*",
  command = "setlocal filetype=config",
})

-- 散文類 filetype 才換行，程式碼保持 nowrap
autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "help" },
  callback = function(args)
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true -- 在單字邊界斷行，不切斷單字
    vim.opt_local.breakindent = true -- 續行對齊原本的縮排
    vim.opt_local.showbreak = "↪ "
    -- j/k 走視覺行，不是實際行
    for _, key in ipairs({ "j", "k" }) do
      vim.keymap.set("n", key, function()
        return vim.v.count == 0 and ("g" .. key) or key
      end, { buffer = args.buf, expr = true })
    end
  end,
})
