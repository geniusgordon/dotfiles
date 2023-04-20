local cmp = require('cmp')
local lspkind = require('lspkind')
lspkind.init()

require('crates').setup()
-- require('copilot_cmp').setup()

cmp.setup({
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-q>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  snippet = {
    expand = function(args)
      require 'luasnip'.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer',  keyword_length = 3 },
    { name = 'crates' },
    -- { name = 'copilot' },
  },
  window = {
    completion = cmp.config.window.bordered({
      winhighlight = 'Normal:Normal,FloatBorder:CmpFloatBorder,CursorLine:Visual,Search:None',
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = 'Normal:Normal,FloatBorder:CmpFloatBorder,CursorLine:Visual,Search:None',
    }),
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      before = function(entry, vim_item)
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[LaTeX]",
          ['vim-dadbod-completion'] = '[DB]',
        })[entry.source.name]

        return vim_item
      end
    }),
  },
  experimental = {
    native_menu = false,
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  },
})

cmp.setup.filetype({ 'sql', 'mysql', 'plsql' }, {
  sources = {
    { name = 'vim-dadbod-completion' },
  }
})

local colors = require("gordon.catppuccin").base_30
vim.api.nvim_set_hl(0, 'CmpFloatBorder', { fg = colors.one_bg3 })
