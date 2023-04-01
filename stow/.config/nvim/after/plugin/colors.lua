function ColorMyPencils(color)
	color = color or "catppuccin"

	require("catppuccin").setup({
		flavour = "mocha",
	})

	vim.cmd.colorscheme(color)
end

ColorMyPencils()
