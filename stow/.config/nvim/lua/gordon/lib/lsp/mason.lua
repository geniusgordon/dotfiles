local M = {}

M.setup = function()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
    },
  })
  require("mason-nvim-dap").setup({
    automatic_setup = true,
    handlers = {},
  })
  -- require('mason-null-ls').setup({
  --   automatic_setup = true,
  --   handlers = {}
  -- })
end

return M
