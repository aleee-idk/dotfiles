-- Additional Plugins
lvim.plugins = {
	-- Sudo support inside vim
	{ "lambdalisue/suda.vim" },

	{
		"blackCauldron7/surround.nvim",
		config = function()
			require("surround").setup({ mappings_style = "sandwich" })
		end,
	},
	{
		"beauwilliams/focus.nvim",
		config = function()
			require("user.plugins.focus")
		end,
	},

	{

		"fszymanski/fzf-gitignore",
		cmd = "FzfGitignore",
	},

	{ "ellisonleao/glow.nvim", run = ":GlowInstall", cmd = ":Glow" },

	{
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
	},

	{
		"NTBBloodbath/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("user.plugins.rest")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("user.plugins.indent-lines")
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			vim.opt.termguicolors = true
			require("colorizer").setup()
		end,
	},
	"tribela/vim-transparent",
	"Mofiqul/dracula.nvim",
	"folke/tokyonight.nvim",
	"tiagovla/tokyodark.nvim",
	"navarasu/onedark.nvim",
	"shaunsingh/moonlight.nvim",
	"yonlu/omni.vim",
	"rafamadriz/neon",
	"nekonako/xresources-nvim",
	"RRethy/nvim-base16",
	{
		"sudormrfbin/cheatsheet.nvim",

		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	},

	{
		"s1n7ax/nvim-comment-frame",
		config = function()
			require("user.plugins.nvim-comment-frame")
		end,
		requires = { "nvim-treesitter" },
	},

	----------------------------------------------------------------------
	--                            Treesitter                            --
	----------------------------------------------------------------------

	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "BufRead",
	},

	{
		"p00f/nvim-ts-rainbow",
	},

	----------------------------------------------------------------------
	--                            Utilities                             --
	----------------------------------------------------------------------

	{
		"abecodes/tabout.nvim",
		config = function()
			require("user.plugins.tabout")
		end,
		wants = "nvim-treesitter",
		after = "nvim-cmp",
	},

	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
	},

	{
		"GustavoKatel/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
		requires = "nvim-lua/plenary.nvim",
		event = "BufRead",
	},

	----------------------------------------------------------------------
	--                                UI                                --
	----------------------------------------------------------------------

	{
		"GustavoKatel/sidebar.nvim",
		config = function()
			require("user.plugins.sidebar")
		end,
	},
}
