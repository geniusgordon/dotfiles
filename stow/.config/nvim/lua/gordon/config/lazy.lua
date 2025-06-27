require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  { "folke/tokyonight.nvim" },
  { "rebelot/kanagawa.nvim" },

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
  { "zbirenbaum/copilot.lua" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    -- See Commands section for default commands if you want to lazy load on them
  },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false, -- set this if you want to always pull the latest change
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },

  { "preservim/vimux" },
  { "vim-test/vim-test" },

  { "norcalli/nvim-colorizer.lua" },
  { "lambdalisue/vim-suda" },
  { "levouh/tint.nvim" },

  { "martineausimon/nvim-lilypond-suite" },

  -- { "OXY2DEV/markview.nvim" },
  -- { "OXY2DEV/helpview.nvim" },
})
