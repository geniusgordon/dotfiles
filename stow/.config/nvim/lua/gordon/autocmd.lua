local autocmd = vim.api.nvim_create_autocmd

autocmd('FileType', {
  pattern = 'make',
  command = 'setlocal noexpandtab',
})

autocmd("BufReadPost", {
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})
