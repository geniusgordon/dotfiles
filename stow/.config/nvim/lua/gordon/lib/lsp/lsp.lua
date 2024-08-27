local M = {}

local builtin = require("telescope.builtin")

local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function lsp_on_attach()
  vim.keymap.set("n", "gh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "Toggle inlay hints" })

  vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, { desc = "Code action" })
  vim.keymap.set("n", "<leader>rn", function()
    vim.lsp.buf.rename()
  end, { desc = "Rename" })

  vim.keymap.set("n", "gq", function()
    vim.diagnostic.setqflist()
  end, { desc = "Show diagnostics in quickfix" })
  vim.keymap.set("n", "<C-j>", function()
    vim.diagnostic.goto_next()
  end, {})
  vim.keymap.set("n", "<C-k>", function()
    vim.diagnostic.goto_prev()
  end, {})
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, {})
  vim.keymap.set("n", "L", function()
    vim.diagnostic.open_float({ focusable = true })
  end, {})

  vim.keymap.set("n", "gr", function()
    builtin.lsp_references({ show_line = false })
  end, { desc = "Find References" })
  vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Find definition" })
  vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Find implementation" })
  -- vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "Find type definition" })
end

local function setup_format_keymap(opts)
  return function(_, bufnr)
    local options = opts or {}
    local format = options.format or vim.lsp.buf.format
    vim.keymap.set("n", "<leader>f", function()
      format()
    end, { desc = "Format", buffer = bufnr })

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        format()
      end,
    })
  end
end

local function setup_null_ls()
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.gofumpt,
      null_ls.builtins.formatting.goimports,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.shfmt.with({
        args = { "-i", "2", "-ci" },
        filetypes = { "sh", "zsh" },
      }),
      null_ls.builtins.formatting.sql_formatter,
      null_ls.builtins.formatting.stylua.with({
        extra_args = {
          "--indent-type=Spaces",
          "--indent-width=2",
        },
      }),
      null_ls.builtins.formatting.terraform_fmt,
      null_ls.builtins.formatting.xmllint,
      null_ls.builtins.formatting.yamlfmt,
    },
    on_attach = setup_format_keymap(),
  })
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

  setup_null_ls()

  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        hint = {
          enable = true,
        },
        format = {
          enable = false,
        },
      },
    },
    on_attach = lsp_on_attach,
    capabilities = capabilities,
  })

  lspconfig.eslint.setup({
    on_attach = setup_format_keymap({
      format = function()
        vim.api.nvim_command("EslintFixAll")
      end,
    }),
    capabilities = capabilities,
  })

  lspconfig.tsserver.setup({
    init_options = {
      preferences = {
        importModuleSpecifierPreference = "relative",
      },
    },
    settings = {
      typescript = {
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
    on_attach = function(client)
      lsp_on_attach()
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    capabilities = capabilities,
  })

  lspconfig.bashls.setup({
    on_attach = lsp_on_attach,
    capabilities = capabilities,
  })

  lspconfig.gopls.setup({
    on_attach = lsp_on_attach,
    capabilities = capabilities,
  })

  lspconfig.terraformls.setup({
    on_attach = lsp_on_attach,
    capabilities = capabilities,
  })

  lspconfig.yamlls.setup({
    on_attach = lsp_on_attach,
    capabilities = capabilities,
  })
end

M.setup_null_ls = setup_null_ls

return M
