return require('packer').startup(
	{
		function ()

			-- General Stuff --

			-- Packer can manage itself
			use 'wbthomason/packer.nvim'

			-- Sudo support
			use 'lambdalisue/suda.vim'

			-- Hot Reload
			-- Not working, check later
			-- use { 'famiu/nvim-reload', requires = { 'nvim-lua/plenary.nvim' }}

			-- Better word motions
			use 'chaoren/vim-wordmotion'

			-- Surround words actions
			use 'tpope/vim-surround'

			-- Add . support to vim-surround
			use 'tpope/vim-repeat'

			-- Window Resize
			use 'simeji/winresizer'

			-- Time Tracker
			use 'ActivityWatch/aw-watcher-vim'

			-- Code Utilities --

			-- LSP
			use 'neovim/nvim-lspconfig'
			use 'kabouzeid/nvim-lspinstall'

			-- Treesitter
			use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }

			-- Fuzzy Finder

			-- Telescope.nvim
			use {
				'nvim-telescope/telescope.nvim',
				requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
			}

			-- Autocompletion
			use 'hrsh7th/nvim-compe'

			-- Function help as you type
			use 'ray-x/lsp_signature.nvim'

			-- Snippets
			use 'SirVer/ultisnips'
			use 'honza/vim-snippets'

			-- Comments
			use 'b3nj5m1n/kommentary'

			-- Markdown
			use { 'iamcco/markdown-preview.nvim', run = [[:call mkdp#util#install()]] }

			use 'fszymanski/fzf-gitignore'

			-- File Managment --
			use 'kyazdani42/nvim-tree.lua'

			-- Better Looking --
			-- Auto Format
			use 'Chiel92/vim-autoformat'

			-- Status Line
			use { 'hoob3rt/lualine.nvim',	requires = {'kyazdani42/nvim-web-devicons', opt = true} }

			-- Ident Lines
			use "lukas-reineke/indent-blankline.nvim"

			-- Color Highlight
			use 'norcalli/nvim-colorizer.lua'

			-- Misc

			-- Dashboard
			use {
				'glepnir/dashboard-nvim',
				cond = function ()
					return true and os.getenv("PLUG") ~= "no" or false
				end
			}

			-- Cheetsheats
			use {
				'sudormrfbin/cheatsheet.nvim',

				requires = {
					{'nvim-telescope/telescope.nvim'},
					{'nvim-lua/popup.nvim'},
					{'nvim-lua/plenary.nvim'},
				}
			}

			-- WichKey
			use 'folke/which-key.nvim'

			-- Color Schemes --

			use 'tribela/vim-transparent'
			use 'Mofiqul/dracula.nvim'
			use 'folke/tokyonight.nvim'
			use 'tiagovla/tokyodark.nvim'
			use 'navarasu/onedark.nvim'
			use 'shaunsingh/moonlight.nvim'
			use 'yonlu/omni.vim'
			use 'rafamadriz/neon'
			use 'nekonako/xresources-nvim'

		end,
		config = {
			display = {
				open_fn = require('packer.util').float,
			}
		}
	}
)
