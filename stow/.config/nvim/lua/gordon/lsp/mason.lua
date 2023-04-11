local M = {}

M.setup =  function ()
  require('mason').setup()
  require('mason-lspconfig').setup({
    ensure_installed = {
      'lua_ls',
    }
  })
  require('mason-nvim-dap').setup({
    automatic_setup = true,
    handlers = {
      function(config)
        -- all sources with no handler get passed here

        -- Keep original functionality
        require('mason-nvim-dap').default_setup(config)
      end,
    }
  })
end

return M
