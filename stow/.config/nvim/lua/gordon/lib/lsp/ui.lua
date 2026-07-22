local M = {}

M.setup = function()
  local border = {
    { "╭", "DiagnosticFloatBorder" },
    { "─", "DiagnosticFloatBorder" },
    { "╮", "DiagnosticFloatBorder" },
    { "│", "DiagnosticFloatBorder" },
    { "╯", "DiagnosticFloatBorder" },
    { "─", "DiagnosticFloatBorder" },
    { "╰", "DiagnosticFloatBorder" },
    { "│", "DiagnosticFloatBorder" },
  }

  local severity = vim.diagnostic.severity

  vim.diagnostic.config({
    signs = {
      text = {
        [severity.ERROR] = "",
        [severity.WARN] = "",
        [severity.INFO] = "",
        [severity.HINT] = "",
      },
      texthl = {
        [severity.ERROR] = "DiagnosticSignError",
        [severity.WARN] = "DiagnosticSignWarn",
        [severity.INFO] = "DiagnosticSignInfo",
        [severity.HINT] = "DiagnosticSignHint",
      },
      numhl = {
        [severity.ERROR] = "DiagnosticVirtualTextError",
        [severity.WARN] = "DiagnosticVirtualTextWarn",
        [severity.INFO] = "DiagnosticVirtualTextInfo",
        [severity.HINT] = "DiagnosticVirtualTextHint",
      },
    },
  })

  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

return M
