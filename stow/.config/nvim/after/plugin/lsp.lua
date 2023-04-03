require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
  }
})

local builtin = require('telescope.builtin')

local on_attach = function(_, _)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, {})
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, {})

  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, {})
  vim.keymap.set("n", "<C-j>", function() vim.diagnostic.goto_next() end, {})
  vim.keymap.set("n", "<C-k>", function() vim.diagnostic.goto_prev() end, {})
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {})

  vim.keymap.set('n', 'gr', builtin.lsp_references, {})
  vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
  vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
  vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, {})
end

local lspconfig = require("lspconfig")

vim.cmd [[autocmd! ColorScheme * highlight LspFloatBorder guifg=white]]

local border = {
  {"╭", "LspFloatBorder"},
  {"─", "LspFloatBorder"},
  {"╮", "LspFloatBorder"},
  {"│", "LspFloatBorder"},
  {"╯", "LspFloatBorder"},
  {"─", "LspFloatBorder"},
  {"╰", "LspFloatBorder"},
  {"│", "LspFloatBorder"},
}

vim.cmd([[
  highlight! DiagnosticLineNrError guibg=#F38BA8 guifg=black
  highlight! DiagnosticLineNrWarn guibg=#F9E2AF guifg=black
  highlight! DiagnosticLineNrInfo guibg=#A6E3A1 guifg=black
  highlight! DiagnosticLineNrHint guibg=#94E2D5 guifg=black
]])


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

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'},
      },
    },
  },
  on_attach = on_attach,
})

lspconfig.eslint.setup({
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

lspconfig.tsserver.setup({
  init_options = {
    preferences = {
      importModuleSpecifierPreference = 'relative',
    },
  },
  on_attach = on_attach,
})
