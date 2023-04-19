local M = {}

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

M.setup = function ()
  local lspconfig = require("lspconfig")
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

  lspconfig.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
