---@diagnostic disable: undefined-global
return require('packer').startup({
    function()

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
        use 'blackCauldron7/surround.nvim'

        -- Window Resize
        use 'simeji/winresizer'

        -- Lua mappings helper
        use 'lazytanuki/nvim-mapper'

        -- Time Tracker
        use 'ActivityWatch/aw-watcher-vim'

        -- Code Utilities --

        -- LSP
        use 'neovim/nvim-lspconfig'
        use 'kabouzeid/nvim-lspinstall'

        -- Python venv support
        -- TODO: don't work, check later
        -- use 'HallerPatrick/py_lsp.nvim'

        -- Show code actions
        use 'kosayoda/nvim-lightbulb'

        -- Treesitter
        use {
            'nvim-treesitter/nvim-treesitter',
            branch = "0.5-compat",
            run = ":TSUpdate"
        }
        use {
            'nvim-treesitter/playground',
            require = 'nvim-treesitter/nvim-treesitter'
        }
        use {
            'romgrk/nvim-treesitter-context',
            require = 'nvim-treesitter/nvim-treesitter'
        }
        use {
            'p00f/nvim-ts-rainbow',
            require = 'nvim-treesitter/nvim-treesitter'
        }

        -- Terminal Support
        use 'akinsho/nvim-toggleterm.lua'

        -- Fuzzy Finder

        -- Telescope.nvim
        use {
            'nvim-telescope/telescope.nvim',
            requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
        }

        use 'nvim-telescope/telescope-media-files.nvim'

        use 'nvim-telescope/telescope-project.nvim'

        -- Harpoon
        use 'ThePrimeagen/harpoon'

        -- Autocompletion
        use 'hrsh7th/nvim-compe'

        -- Pictograms in Autocompletion
        use 'onsails/lspkind-nvim'

        -- Function help as you type
        use 'ray-x/lsp_signature.nvim'

        -- Snippets
        use 'SirVer/ultisnips'
        use 'honza/vim-snippets'

        -- Comments
        use 'b3nj5m1n/kommentary'

        -- Markdown
        use {
            'iamcco/markdown-preview.nvim',
            run = [[:call mkdp#util#install()]]
        }

        use 'fszymanski/fzf-gitignore'

        -- Peak lines
        use 'nacro90/numb.nvim'

        -- Split lines
        use {
            'AckslD/nvim-revJ.lua',
            requires = {'kana/vim-textobj-user', 'sgur/vim-textobj-parameter'}
        }

        use 'windwp/nvim-autopairs'

        -- File Managment --
        use 'kyazdani42/nvim-tree.lua'

        -- Better Looking --
        -- Auto Format
        use 'mhartington/formatter.nvim'

        -- Align stuff
        use 'junegunn/vim-easy-align'

        -- Status Line
        use {
            'hoob3rt/lualine.nvim',
            requires = {'kyazdani42/nvim-web-devicons', opt = true}
        }

        -- CursorLine
        use 'xiyaowong/nvim-cursorword'

        -- Ident Lines
        use "lukas-reineke/indent-blankline.nvim"

        -- Color Highlight
        use 'norcalli/nvim-colorizer.lua'

        -- Misc

        -- Dashboard
        use {
            'glepnir/dashboard-nvim',
            cond = function()
                return true and os.getenv("PLUG") ~= "no" or false
            end
        }

        -- Cheetsheats
        use {
            'sudormrfbin/cheatsheet.nvim',

            requires = {
                {'nvim-telescope/telescope.nvim'}, {'nvim-lua/popup.nvim'},
                {'nvim-lua/plenary.nvim'}
            }
        }

        -- WichKey
        use 'folke/which-key.nvim'

        -- Zen Mode
        use {"folke/zen-mode.nvim", requires = {"folke/twilight.nvim"}}

        -- Create "Headers"
        use {'s1n7ax/nvim-comment-frame', requires = {{'nvim-treesitter'}}}

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
        use 'RRethy/nvim-base16'

    end,
    config = {display = {open_fn = require('packer.util').float}}
})
