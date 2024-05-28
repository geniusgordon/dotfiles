require("lazy").setup({
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
	{ "folke/tokyonight.nvim" },

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

	-- git
	{ "tpope/vim-fugitive" },
	{ "sindrets/diffview.nvim" },
	{ "lewis6991/gitsigns.nvim" },

	{ "folke/zen-mode.nvim" },
	{ "mbbill/undotree" },

	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-lualine/lualine.nvim" },
	{ "akinsho/bufferline.nvim" },
	{ "nvim-tree/nvim-tree.lua" },
	{ "stevearc/oil.nvim" },
	{ "alexghergh/nvim-tmux-navigation" },
	{ "zbirenbaum/copilot.lua" },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "chrisbra/csv.vim" },

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
	{ "zbirenbaum/copilot-cmp" },

	-- lsp
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{ "folke/neodev.nvim" },

	-- dap
	{ "mfussenegger/nvim-dap" },
	{ "jay-babu/mason-nvim-dap.nvim" },
	{ "rcarriga/nvim-dap-ui" },

	-- format
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},

	{ "j-hui/fidget.nvim", tag = "legacy" },
	{ "folke/which-key.nvim" },

	-- {
	-- 	"rest-nvim/rest.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- },

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
		},
	},
})