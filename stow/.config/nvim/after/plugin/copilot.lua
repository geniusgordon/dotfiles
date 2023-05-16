-- vim.g.copilot_filetypes = {
--   gitcommit = true,
--   markdown = true,
--   yaml = true
-- }
--
-- vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)")
-- vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)")
-- vim.keymap.set("i", "<C-l>", "<Plug>(copilot-suggest)")
--
require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = false,
			accept_word = false,
			accept_line = false,
			next = "<C-j>",
			prev = "<C-k>",
			dismiss = "<C-l>",
		},
	},
	filetypes = {
		yaml = false,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
	},
	copilot_node_command = "node", -- Node.js version must be > 16.x
	server_opts_overrides = {},
})

vim.keymap.set("i", "<Tab>", function()
	if require("copilot.suggestion").is_visible() then
		require("copilot.suggestion").accept()
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
	end
end, {
	silent = true,
})

vim.keymap.set("i", "<S-Tab>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").previous()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
  end
end, {
  silent = true,
})

vim.keymap.set("i", "<C-f>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept_word()
  end
end, {
  silent = true,
})

vim.keymap.set("i", "<C-g>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept_line()
  end
end, {
  silent = true,
})
