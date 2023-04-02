-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  })

  use({ "catppuccin/nvim", as = "catppuccin" })

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('tpope/vim-commentary')

  use({
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'onsails/lspkind.nvim' },
      { 'L3MON4D3/LuaSnip' }, -- Required
    }
  })

  use('nvim-tree/nvim-web-devicons')
  use('nvim-lualine/lualine.nvim')

  use('github/copilot.vim')
end)
