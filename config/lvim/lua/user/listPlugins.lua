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
	{ "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },

	{
		"ur4ltz/surround.nvim",
		config = function()
			require("surround").setup({ mappings_style = "sandwich" })
		end,
		event = "VimEnter",
	},
	{
		"beauwilliams/focus.nvim",
		config = function()
			require("user.plugins.focus")
		end,
		event = "VimEnter",
	},

	{
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
		event = "VimEnter",
	},

	-- {
	-- 	"NTBBloodbath/rest.nvim",
	-- 	requires = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("user.plugins.rest")
	-- 	end,
	-- },

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
		"akinsho/flutter-tools.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("user.plugins.flutter-tools")
		end,
		ft = "dart",
	},

	{
		"elkowar/yuck.vim",
		ft = "yuck",
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
		event = "BufRead",
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			vim.opt.termguicolors = true
			require("colorizer").setup()
		end,
		event = "BufRead",
	},

	{
		"catppuccin/nvim",
		as = "catppuccin",
	},

	-- "tribela/vim-transparent",
	-- "Mofiqul/dracula.nvim",
	-- "folke/tokyonight.nvim",
	-- "tiagovla/tokyodark.nvim",
	-- "navarasu/onedark.nvim",
	-- "shaunsingh/moonlight.nvim",
	-- "yonlu/omni.vim",
	-- "rafamadriz/neon",
	-- "nekonako/xresources-nvim",
	-- "RRethy/nvim-base16",

	{
		"sudormrfbin/cheatsheet.nvim",

		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		cmd = "Cheatsheet",
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
		ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
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
		event = "BufRead",
	},

	{
		"lewis6991/spellsitter.nvim",
		event = "BufRead",
		config = function()
			require("spellsitter").setup()
		end,
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
		event = "BufRead",
	},

	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				enabled = true,
			})
			lvim.builtin.which_key.mappings["n"] = {
				name = "Neogen",
				g = { "<cmd>Neogen<cr>", "Generate" },
			}
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	},

	----------------------------------------------------------------------
	--                            Utilities                             --
	----------------------------------------------------------------------

	-- {
	-- 	"abecodes/tabout.nvim",
	-- 	config = function()
	-- 		require("user.plugins.tabout")
	-- 	end,
	-- 	wants = "nvim-treesitter",
	-- 	after = "nvim-cmp",
	-- },

	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
		event = "BufRead",
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
		event = "VimEnter",
	},

	-- Hide UI
	{
		"Chaitanyabsprip/present.nvim",
		config = function()
			require("present").setup({
				default_mappings = true,
				kitty = {
					normal_font_size = 11,
					zoom_font_size = 11,
				},
			})
		end,
		cmd = "Present",
	},
}
