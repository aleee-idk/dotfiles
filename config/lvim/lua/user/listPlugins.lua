-- Additional Plugins
lvim.plugins = {

	----------------------------------------------------------------------
	--                            Code Stuff                            --
	----------------------------------------------------------------------
	{
		"pianocomposer321/yabs.nvim",
		config = function()
			require("user.plugins.yabs")
		end,
	},

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
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({
				tools = {
					autoSetHints = true,
					hover_with_actions = true,
					runnables = {
						use_telescope = true,
					},
				},
				server = {
					cmd = { vim.fn.stdpath("data") .. "/lsp_servers/rust/rust-analyzer" },
					on_attach = require("lvim.lsp").common_on_attach,
					on_init = require("lvim.lsp").common_on_init,
				},
			})
		end,
		ft = { "rust", "rs" },
	},

	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
	},

	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		config = function()
			require("user.plugins.trouble")
		end,
	},
	----------------------------------------------------------------------
	--                            Aesthetics                            --
	----------------------------------------------------------------------

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
		"romgrk/nvim-treesitter-context",
		event = "BufRead",
		config = function()
			require("treesitter-context").setup({})
		end,
	},

	{
		"p00f/nvim-ts-rainbow",
	},

	{
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
		end,
	},
	{
		"haringsrob/nvim_context_vt",
	},
	{
		"mfussenegger/nvim-ts-hint-textobject",
		config = function()
			vim.api.nvim_set_keymap(
				"o",
				"m",
				[[:<C-U>lua require('tsht').nodes()<CR>]],
				{ silent = true, noremap = true }
			)
			vim.api.nvim_set_keymap("v", "m", [[:lua require('tsht').nodes()<CR>]], { silent = true, noremap = true })
			require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
		end,
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

	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		run = "cd app && yarn install",
	},

	{
		"mzlogin/vim-markdown-toc",
		ft = { "markdown" },
	},

	{
		"henriquehbr/nvim-startup.lua",
		config = function()
			require("nvim-startup").setup()
		end,
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
