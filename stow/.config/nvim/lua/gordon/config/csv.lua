local csv = require("gordon.lib.csv")
local csv_group = vim.api.nvim_create_augroup("csv", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "csv",
	callback = function()
		vim.keymap.set("n", "<leader>h", csv.toggle_header, { desc = "Toggle CSV Header" })
		vim.keymap.set("n", "<leader>H", csv.toggle_vheader, { desc = "Toggle CSV Vertical Header" })
		vim.keymap.set("n", "<leader>a", csv.arrange_column, { desc = "Arrange CSV Column" })
		vim.keymap.set("n", "<leader>A", csv.unarrange_column, { desc = "Unarrange CSV Column" })
	end,
	group = csv_group,
})
