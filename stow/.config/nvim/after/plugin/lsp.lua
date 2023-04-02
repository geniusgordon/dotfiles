local lsp = require('lsp-zero').preset({
  manage_nvim_cmp = {
    set_sources = 'recommended'
  }
})

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.eslint.setup({
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  },
})

cmp.setup({
  mapping = cmp_mappings,
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = require('lspkind').cmp_format({
      mode = 'symbol',       -- show only symbol annotations
      maxwidth = 50,         -- prevent the popup from showing more than provided characters
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
    })
  }
})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<C-j>", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<C-k>", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
end)

lsp.format_on_save({
  servers = {
    ['jsonls'] = { 'json' },
    ['yamlls'] = { 'yaml' },
    ['terraformls'] = { 'terraform' },
    ['rust_analyzer'] = { 'rust' },
    ['html'] = { 'html' },
    ['docker_compose_language_service'] = {},
    ['dockerls'] = { 'docker' },
    ['gopls'] = { 'golang' },
    ['pylsp'] = { 'python' },
    ['lua_ls'] = { 'lua' },
    ['kotlin_language_server'] = { 'kotlin' },
    ['cmake'] = { 'make' },
    ['bashls'] = { 'bash' },
    ['vimls'] = { 'vim' },
  }
})

lsp.setup()
