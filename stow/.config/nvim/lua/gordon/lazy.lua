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
  { 'nvim-tree/nvim-tree.lua' },
  -- {
  --   'nvim-neo-tree/neo-tree.nvim',
  --   branch = 'v2.x',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
  --     'MunifTanjim/nui.nvim',
  --   }
  -- },
  { 'alexghergh/nvim-tmux-navigation' },
  { 'lewis6991/gitsigns.nvim' },
  -- { 'RRethy/vim-illuminate' },
  -- { 'github/copilot.vim' },
  { 'zbirenbaum/copilot.lua' },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

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
  {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  { 'zbirenbaum/copilot-cmp' },

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

  -- format
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
  },

  { 'j-hui/fidget.nvim' },
  { 'folke/which-key.nvim' },

  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
    },
  },
})
