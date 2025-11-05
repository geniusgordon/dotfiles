require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  { "folke/tokyonight.nvim" },
  { "rebelot/kanagawa.nvim" },

  { "MunifTanjim/nui.nvim" },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "nvim-neotest/nvim-nio" },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope-dap.nvim" },
  { "camgraff/telescope-tmux.nvim" },
  { "FeiyouG/commander.nvim" },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },

  -- git
  { "tpope/vim-fugitive" },
  { "sindrets/diffview.nvim" },
  { "lewis6991/gitsigns.nvim" },
  { "akinsho/git-conflict.nvim" },

  { "folke/zen-mode.nvim" },
  { "mbbill/undotree" },

  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lualine/lualine.nvim" },
  { "akinsho/bufferline.nvim" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
  { "nvim-tree/nvim-tree.lua" },
  { "stevearc/oil.nvim" },
  { "hedyhli/outline.nvim" },
  { "alexghergh/nvim-tmux-navigation" },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- { "chrisbra/csv.vim" },
  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
  },

  -- completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "onsails/lspkind.nvim" },
  { "saadparwaiz1/cmp_luasnip" },
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "ray-x/cmp-treesitter" },
  { "kristijanhusak/vim-dadbod-completion" },

  -- lsp
  { "neovim/nvim-lspconfig" },
  -- {
  --   "williamboman/mason.nvim",
  --   build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  -- },
  -- { "williamboman/mason-lspconfig.nvim" },
  { "mason-org/mason.nvim", version = "^1.0.0" },
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
  { "folke/neodev.nvim" },

  -- dap
  { "mfussenegger/nvim-dap" },
  { "jay-babu/mason-nvim-dap.nvim" },
  { "rcarriga/nvim-dap-ui" },

  -- format
  { "nvimtools/none-ls.nvim" },
  { "jay-babu/mason-null-ls.nvim" },
  { "folke/trouble.nvim" },
  { "j-hui/fidget.nvim" },

  -- tailwind
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  { "folke/which-key.nvim" },

  { "kylechui/nvim-surround" },

  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    },
  },
  {
    "rest-nvim/rest.nvim",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- ai
  {
    "Exafunction/windsurf.vim",
    event = "BufEnter",
  },

  { "preservim/vimux" },
  { "vim-test/vim-test" },

  { "norcalli/nvim-colorizer.lua" },
  { "lambdalisue/vim-suda" },
  { "levouh/tint.nvim" },

  { "martineausimon/nvim-lilypond-suite" },

  {
    "alex-popov-tech/store.nvim",
    cmd = "Store",
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "gs", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- { "OXY2DEV/markview.nvim" },
  -- { "OXY2DEV/helpview.nvim" },
})
