---@diagnostic disable: undefined-global
return require('packer').startup({
    function()

        ----------------------------------------------------------------------
        --                          General Stuff                           --
        ----------------------------------------------------------------------

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
        use {
            'blackCauldron7/surround.nvim',
            config = function()
                require"surround".setup {mappings_style = "sandwich"}
            end
        }

        -- Window Managment
        use {
            'beauwilliams/focus.nvim',
            config = function() require('plugins.focus') end
        }

        -- Lua mappings helper
        use 'lazytanuki/nvim-mapper'

        ----------------------------------------------------------------------
        --                          Code Utilities                          --
        --                               and                                --
        --                         Editing Support                          --
        ----------------------------------------------------------------------

        -- LSP
        use 'neovim/nvim-lspconfig'
        use 'kabouzeid/nvim-lspinstall'

        use {
            'glepnir/lspsaga.nvim',
            config = function() require('plugins.lspsaga') end
        }

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

        use 'haringsrob/nvim_context_vt'

        -- Autocompletion
        use {
            'hrsh7th/nvim-cmp',
            config = function() require('plugins.autocompletion') end,
            requires = {

                'hrsh7th/cmp-nvim-lsp', 'saadparwaiz1/cmp_luasnip',
                'L3MON4D3/LuaSnip', 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lua',
                'hrsh7th/cmp-buffer', 'hrsh7th/cmp-calc', 'ray-x/cmp-treesitter'
            }
        }

        -- Auto Format
        use 'mhartington/formatter.nvim'

        use 'windwp/nvim-autopairs'

        use {
            'windwp/nvim-ts-autotag',
            ft = {'javascript', 'typescript', 'html'},
            config = function()
                require'nvim-treesitter.configs'.setup {
                    autotag = {enable = true}
                }
            end
        }

        ----------------------------------------------------------------------
        --                               Git                                --
        ----------------------------------------------------------------------

        use {
            'TimUntersberger/neogit',
            cmd = "Neogit",
            requires = 'nvim-lua/plenary.nvim'
        }

        use {
            'lewis6991/gitsigns.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = [[require("plugins.gitsigns")]]
        }

        -- Create gitignore files using gitignore-io API
        use 'fszymanski/fzf-gitignore'

        ----------------------------------------------------------------------
        --                          File Managment                          --
        --                               and                                --
        --                            Navigation                            --
        ----------------------------------------------------------------------

        -- File Managment --
        use 'kyazdani42/nvim-tree.lua'

        -- Fuzzy Finder
        use {
            'nvim-telescope/telescope.nvim',
            requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
            config = [[require("plugins.telescope") ]]
        }

        use 'nvim-telescope/telescope-media-files.nvim'

        use {
            'ahmedkhalf/project.nvim',
            config = [[ require("plugins.projects") ]]
        }

        -- Easy access to recurrent files
        use 'ThePrimeagen/harpoon'

        ----------------------------------------------------------------------
        --                            Utilities                             --
        ----------------------------------------------------------------------

        -- Terminal Support
        use 'akinsho/nvim-toggleterm.lua'

        -- Pictograms in Autocompletion
        use 'onsails/lspkind-nvim'

        -- Function help as you type
        use 'ray-x/lsp_signature.nvim'

        -- Comments
        use 'b3nj5m1n/kommentary' -- Markdown

        use {'ellisonleao/glow.nvim', run = ":GlowInstall"}

        -- Peak lines
        use {
            'nacro90/numb.nvim',
            config = function() require('numb').setup() end
        }

        -- Align stuff
        use 'junegunn/vim-easy-align'

        -- Rest Client (Curl Wrapper)
        use {
            'NTBBloodbath/rest.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function() require('plugins.rest') end
        }

        ----------------------------------------------------------------------
        --                            Aesthetics                            --
        ----------------------------------------------------------------------

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
        use {
            'norcalli/nvim-colorizer.lua',
            config = function()
                vim.opt.termguicolors = true
                require'colorizer'.setup()

            end
        }

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

        ----------------------------------------------------------------------
        --                               Halp                               --
        ----------------------------------------------------------------------

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

        ----------------------------------------------------------------------
        --                               Misc                               --
        ----------------------------------------------------------------------

        -- Dashboard
        use {
            'glepnir/dashboard-nvim',
            cond = function()
                return true and os.getenv("PLUG") ~= "no" or false
            end
        }

    end,
    config = {display = {open_fn = require('packer.util').float}}
})
