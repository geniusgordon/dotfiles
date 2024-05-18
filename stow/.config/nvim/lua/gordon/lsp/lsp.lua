local M = {}

local builtin = require("telescope.builtin")

local on_attach = function(_, _)
  vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, { desc = "Code Action" })
  vim.keymap.set("n", "<leader>rn", function()
    vim.lsp.buf.rename()
  end, { desc = "Rename" })

  vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
  end, { desc = "Show Diagnostics" })
  vim.keymap.set("n", "<C-j>", function()
    vim.diagnostic.goto_next()
  end, {})
  vim.keymap.set("n", "<C-k>", function()
    vim.diagnostic.goto_prev()
  end, {})
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, {})

  vim.keymap.set("n", "gr", function()
    builtin.lsp_references({ show_line = false })
  end, { desc = "Find References" })
  vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Find Definition" })
  vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Find Implementation" })
  vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "Find Type Definition" })
end

M.setup = function()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.diagnostic.config({
    virtual_text = false,
    float = {
      show_header = true,
      format = function(diagnostic)
        if diagnostic.source == "typescript" then
          local result = vim.fn.system({ "pretty-ts-error", diagnostic.message })
          return string.format("%s\n%s\n", result, diagnostic.source)
        end
        return string.format("%s\n%s\n", diagnostic.message, diagnostic.source)
      end,
    },
  })

  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        hint = {
          enable = true,
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
        importModuleSpecifierPreference = "relative"
      }
    },
    settings = {
      typescript = {
        preferences = {
          importModuleSpecifier = "relative"
        },
        inlayHints = {
          includeInlayParameterNameHints = "literals",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        preferences = {
          importModuleSpecifier = "relative",
        },
        inlayHints = {
          includeInlayParameterNameHints = "literals",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
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

  lspconfig.graphql.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
