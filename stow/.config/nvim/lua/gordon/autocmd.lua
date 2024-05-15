local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
	pattern = "make",
	command = "setlocal noexpandtab",
})

autocmd("BufReadPost", {
	command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})

autocmd("FileType", {
	pattern = "xml",
	command = "setlocal foldmethod=syntax",
})

autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.http",
	command = "setlocal filetype=http",
})

autocmd({ "BufRead", "BufNewFile" }, {
	pattern = ".env*",
	command = "setlocal filetype=config",
})
