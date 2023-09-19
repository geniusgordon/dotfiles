local csv_group = vim.api.nvim_create_augroup("csv", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "csv",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<leader>h", ":HeaderToggle<CR>", {
			desc = "Toggle Csv Header",
		})
		vim.api.nvim_buf_set_keymap(0, "n", "<leader>H", ":VHeaderToggle<CR>", {
			desc = "Toggle Csv Header",
		})
		vim.api.nvim_buf_set_keymap(0, "n", "<leader>a", ":%CSVArrangeColumn<CR>", {
			desc = "Arrange Csv Column",
		})
		vim.api.nvim_buf_set_keymap(0, "n", "<leader>A", ":%CSVUnArrangeColumn<CR>", {
			desc = "Unarrange Csv Column",
		})
	end,
	group = csv_group,
})
