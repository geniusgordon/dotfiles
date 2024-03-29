return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use("ThePrimeagen/vim-be-good")
  use("TimUntersberger/neogit")
  use({
    'sindrets/diffview.nvim',
    requires = {'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons'}
  })
  use('akinsho/git-conflict.nvim')
  use("APZelos/blamer.nvim")
  use('nvim-tree/nvim-tree.lua')

  -- TJ created lodash of neovim
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")

  use('nvim-lualine/lualine.nvim')

  use("mbbill/undotree")

  use('SirVer/ultisnips')
  use{'neoclide/coc.nvim', branch = 'release'}
  use("fannheyward/telescope-coc.nvim")

  use('vim-scripts/IndexedSearch')
  use('airblade/vim-gitgutter')
  use('tpope/vim-commentary')
  -- use('tpope/vim-fugitive')
  use('tpope/vim-abolish') -- fast manipulations
  use('tpope/vim-unimpaired')
  use('tpope/vim-surround')
  use('wellle/targets.vim') --adds various text objects
  use('andymass/vim-matchup') --better % navigation
  use('sk1418/HowMuch')
  use('christianrondeau/vim-base64')
  -- use('christoomey/vim-tmux-navigator')

  -- color theme
  -- use('folke/tokyonight.nvim')
  use { "catppuccin/nvim", as = "catppuccin" }

  -- language
  use('pangloss/vim-javascript')
  use('MaxMEllon/vim-jsx-pretty')
  use('hashivim/vim-terraform')

  use('github/copilot.vim')
end)
