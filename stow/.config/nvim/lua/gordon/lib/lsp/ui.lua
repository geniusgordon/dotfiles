local M = {}

M.setup = function()
	local colors = require("gordon.lib.colors").base_30

	vim.api.nvim_set_hl(0, "@lsp.type.function.typescript", {})

	vim.api.nvim_set_hl(0, "LspFloatBorder", { fg = colors.one_bg3 })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.black })

	local border = {
		{ "╭", "LspFloatBorder" },
		{ "─", "LspFloatBorder" },
		{ "╮", "LspFloatBorder" },
		{ "│", "LspFloatBorder" },
		{ "╯", "LspFloatBorder" },
		{ "─", "LspFloatBorder" },
		{ "╰", "LspFloatBorder" },
		{ "│", "LspFloatBorder" },
	}

	vim.api.nvim_set_hl(0, "DiagnosticLineNrError", { link = "DiagnosticVirtualTextError" })
	vim.api.nvim_set_hl(0, "DiagnosticLineNrWarn", { link = "DiagnosticVirtualTextWarn" })
	vim.api.nvim_set_hl(0, "DiagnosticLineNrInfo", { link = "DiagnosticVirtualTextInfo" })
	vim.api.nvim_set_hl(0, "DiagnosticLineNrHint", { link = "DiagnosticVirtualTextHint" })

	vim.api.nvim_set_hl(0, "DiagnosticBgError", { bg = colors.red, fg = colors.one_bg })
	vim.api.nvim_set_hl(0, "DiagnosticBgWarn", { bg = colors.yellow, fg = colors.one_bg })
	vim.api.nvim_set_hl(0, "DiagnosticBgInfo", { bg = colors.blue, fg = colors.one_bg })
	vim.api.nvim_set_hl(0, "DiagnosticBgHint", { bg = colors.green, fg = colors.one_bg })

	vim.cmd([[
  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
  ]])

	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or border
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end
end

return M
