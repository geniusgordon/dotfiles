require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
  }
})

local builtin = require('telescope.builtin')

local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, {})
  vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, {})

  vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, {})
  vim.keymap.set('n', '<C-j>', function() vim.diagnostic.goto_next() end, {})
  vim.keymap.set('n', '<C-k>', function() vim.diagnostic.goto_prev() end, {})
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, {})

  vim.keymap.set('n', 'gr', builtin.lsp_references, {})
  vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
  vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
  vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, {})
end

local lspconfig = require("lspconfig")
local colors = require("gordon.catppuccin").base_30

vim.api.nvim_set_hl(0, 'LspFloatBorder', { fg = colors.one_bg3 })

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

vim.api.nvim_set_hl(0, 'DiagnosticLineNrError', { bg = colors.red, fg = colors.black })
vim.api.nvim_set_hl(0, 'DiagnosticLineNrWarn', { bg = colors.orange, fg = colors.black })
vim.api.nvim_set_hl(0, 'DiagnosticLineNrInfo', { bg = colors.green, fg = colors.black })
vim.api.nvim_set_hl(0, 'DiagnosticLineNrHint', { bg = colors.cyan, fg = colors.black })

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

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.eslint.setup({
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  capabilities = capabilities,
})

lspconfig.tsserver.setup({
  init_options = {
    preferences = {
      importModuleSpecifierPreference = 'relative',
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.lemminx.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
