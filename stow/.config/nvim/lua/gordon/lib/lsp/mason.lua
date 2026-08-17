local M = {}

M.setup = function()
  require("mason").setup()
  require("mason-lspconfig").setup({
    -- Keep this list equal to the vim.lsp.enable list in lsp.lua.
    ensure_installed = {
      "lua_ls",
      "tailwindcss",
      "eslint",
      "bashls",
      -- Add "gopls" here after you install the Go toolchain. Mason builds it from source.
      "terraformls",
      "yamlls",
    },
  })
  require("mason-nvim-dap").setup({
    -- automatic_setup = true,
    handlers = {},
  })
  -- require('mason-null-ls').setup({
  --   automatic_setup = true,
  --   handlers = {}
  -- })
end

return M
