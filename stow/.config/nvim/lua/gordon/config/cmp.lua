local cmp = require("cmp")
local lspkind = require("lspkind")
local devicons = require("nvim-web-devicons")

require("copilot_cmp").setup()

lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

cmp.setup({
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-q>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sources = {
    { name = "copilot" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = 'nvim_lsp_signature_help' },
    { name = "path" },
    { name = "buffer",                 keyword_length = 3 },
    { name = "crates" },
    { name = "luasnip" },
    {
      name = "spell",
      keyword_length = 3,
      option = {
        keep_all_entries = false,
        enable_in_context = function()
          return true
        end,
        preselect_correct_word = true,
      },
    },
    { name = 'vim-dadbod-completion' },
  },
  window = {
    completion = cmp.config.window.bordered({
      winhighlight = "Normal:Normal,FloatBorder:CmpFloatBorder,CursorLine:Visual,Search:None",
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = "Normal:Normal,FloatBorder:CmpFloatBorder,CursorLine:Visual,Search:None",
    }),
  },
  formatting = {
    expandable_indicator = false,
    fields = { "abbr", "kind", "menu" },
    format = function(entry, item)
      local menu = ({
        buffer = "Buffer",
        nvim_lsp = "LSP",
        luasnip = "LuaSnip",
        nvim_lua = "Lua",
        latex_symbols = "LaTeX",
        ["vim-dadbod-completion"] = "DB",
        spell = "Spell",
      })[entry.source.name]
      item.menu = menu or string.format("%s", entry.source.name)

      if entry.source.name == 'vim-dadbod-completion' then
        item.kind = '󰆼 DB'
        local documentation = entry.get_completion_item(entry).documentation
        if documentation == 'SQL reserved word' then
          local icon = lspkind.presets.default.Keyword
          item.kind = string.format("%s Keyword", icon)
          item.kind_hl_group = 'CmpItemKindKeyword'
        end
        if documentation == 'table' then
          local icon = lspkind.presets.default.Struct
          item.kind = string.format("%s Table", icon)
          item.kind_hl_group = 'CmpItemKindStruct'
        end
        if type(documentation) == 'string' and string.find(documentation, 'column') then
          local icon = lspkind.presets.default.Field
          item.kind = string.format("%s Column", icon)
          item.kind_hl_group = 'CmpItemKindField'
        end

        return item
      end

      if entry.source.name == 'spell' then
        item.kind = '󰓆 Spell'
        item.kind_hl_group = 'CmpItemKindSnippet'
        return item
      end

      if vim.tbl_contains({ 'path' }, entry.source.name) then
        local label = entry.get_completion_item(entry).label
        local icon, hl_group = devicons.get_icon(label)
        if icon then
          item.kind = string.format("%s File", icon)
          item.kind_hl_group = hl_group
          return item
        end
      end

      return lspkind.cmp_format({
        with_text = true,
        formatting = {
          format = function(_, vim_item)
            local icon = lspkind.presets.default[vim_item.kind]
            vim_item.kind = string.format("%s %s", icon, vim_item.kind)
            return vim_item
          end
        },
      })(entry, item)
    end,
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
  sources = {
    { name = "vim-dadbod-completion", keyword_length = 3 },
  },
})

local colors = require("gordon.lib.colors").base_30
vim.api.nvim_set_hl(0, "CmpFloatBorder", { fg = colors.one_bg3 })
vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "CmpItemAbbr", italic = true })
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
