require("lazy").setup({
  { 'catppuccin/nvim', name = 'catppuccin' },
  {
    'nvim-telescope/telescope.nvim',
    dependencies  = { { 'nvim-lua/plenary.nvim' } }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
  'nvim-treesitter/playground',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  'tpope/vim-commentary',
  'nvim-tree/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  'github/copilot.vim',
})
