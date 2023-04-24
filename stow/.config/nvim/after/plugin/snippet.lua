local ls = require('luasnip')
require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/snippets' })

ls.setup({
  update_events = { "TextChanged", "TextChangedI" }
})

vim.keymap.set({ 'i', 's' }, '<C-e>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end)

vim.keymap.set('i', '<C-w>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)

vim.keymap.set('i', '<C-l>', function()
  if ls.choice_active(1) then
    ls.change_choice(1)
  end
end)
