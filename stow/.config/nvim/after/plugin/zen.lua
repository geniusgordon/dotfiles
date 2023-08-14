vim.keymap.set("n", "<leader>z", function()
	require("zen-mode").toggle({
		window = {
			width = 90,
		},
    plugins = {
      tmux = { enabled = true },
			wezterm = {
				enabled = true,
				-- can be either an absolute font size or the number of incremental steps
				font = "+4", -- (10% increase per step)
			},
		},
	})
end, { desc = "Toggle zen mode" })
