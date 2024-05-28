local M = {}
local oil = require("oil")

M.setup = function()
	oil.setup({
		-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
		-- Set to false if you still want to use netrw.
		default_file_explorer = true,
		-- Id is automatically added at the beginning, and name at the end
		-- See :help oil-columns
		-- columns = {
		-- 	"icon",
		-- 	-- "permissions",
		-- 	-- "size",
		-- 	-- "mtime",
		-- },
	})

	vim.keymap.set("n", "-", function()
		oil.open()
	end, { noremap = true, silent = true, desc = "Open file explorer" })
end

return M
