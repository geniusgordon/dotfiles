require("lazy").setup({
  {
    'catppuccin/nvim',
    name = 'catppuccin'
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
  { 'nvim-treesitter/playground' },
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  -- { 'tpope/vim-commentary' },
  { 'numToStr/Comment.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-lualine/lualine.nvim' },
  { 'github/copilot.vim' },
  { 'nvim-tree/nvim-tree.lua' },
  { 'alexghergh/nvim-tmux-navigation' },
  { 'lewis6991/gitsigns.nvim' },
  { 'RRethy/vim-illuminate' },

  -- completion
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' },
  { 'onsails/lspkind.nvim' },
  { 'saadparwaiz1/cmp_luasnip' },

  -- lsp
  { 'neovim/nvim-lspconfig' },
  {
    'williamboman/mason.nvim',
    build = ":MasonUpdate" -- :MasonUpdate updates registry contents
  },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'folke/neodev.nvim' },

  -- dap
  { 'mfussenegger/nvim-dap' },
  { 'jay-babu/mason-nvim-dap.nvim' },
  { 'rcarriga/nvim-dap-ui' },

  { 'j-hui/fidget.nvim' },
  { 'folke/which-key.nvim' },
})
