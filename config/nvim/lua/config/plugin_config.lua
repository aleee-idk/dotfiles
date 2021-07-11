--[[
vim.opt.{option}         ->  :set
vim.opt_global.{option}  ->  :setglobal
vim.opt_local.{option}   ->  :setlocal
--]]

-- LSP

local nvim_lsp = require("lspconfig")  

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<Leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', 'g{', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', 'g}', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap("n", "<Leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

	-- TODO: Config https://github.com/ray-x/lsp_signature.nvim
	require ('lsp_signature').on_attach()

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local function setup_servers()
	require'lspinstall'.setup()
	local servers = require'lspinstall'.installed_servers()
	for _, server in pairs(servers) do
		nvim_lsp[server].setup {
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' }
					}
				}
			}
		}
	end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
	setup_servers() -- reload installed servers
	vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- Treesitter

-- Note: Available capture groups and highlight group identifiers will be found in https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/highlight.lua file in the source code.

require('nvim-treesitter.configs').setup({
	ensure_installed = "all",

	highlight = {
		enable = true,
		custom_captures = {
			-- ["<capture group>"] = "<highlight group>",
			-- ["keyword"] = "TSString",
		},
	},

	incremental_selection = {
enable = true,
-- keymaps = {
--     init_selection = "gnn",
--     node_incremental = "grn",
		--     scope_incremental = "grc",
		--     node_decremental = "grm",
		-- },
	},

	indent = {
		enable = true
	},
})

vim.api.nvim_exec([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
	]], true)

-- Telescope.nvim
-- Open
vim.api.nvim_set_keymap('n', "<Leader>ff", [[<cmd>Telescope find_files<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', "<Leader>fF", [[<cmd>Telescope file_browser<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', "<Leader>fs", [[<cmd>Telescope grep_string<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', "<Leader>fg", [[<cmd>Telescope live_grep<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', "<Leader>fb", [[<cmd>Telescope buffers<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', "<Leader>fh", [[<cmd>Telescope help_tags<CR>]], { noremap = true })

-- Config
local actions = require("telescope.actions")
require('telescope').setup{
	defaults = {
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		color_devicons = true,
		entry_prefix = "  ",
		initial_mode = "insert",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		file_ignore_patterns = {
			"%.env",
			"cache",
			".xlsx",
		},
		file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
		file_sorter =  require'telescope.sorters'.get_fuzzy_file,
		generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
		grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
		mappings = {
i = {
-- To disable a keymap, put [map] = false
-- Otherwise, just set the mapping to the function that you want it to be.
				-- ["<C-i>"] = actions.select_horizontal,
				-- Add up multiple actions
				-- ["<cr>"] = actions.select_default + actions.center,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-s>"] = actions.file_vsplit,
				["<C-v>"] = actions.file_split,
			},
			n = {
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,
				["s"] = actions.file_vsplit,
				["v"] = actions.file_split,
			},
		},
		prompt_prefix = "> ",
		qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
		scroll_strategy = nil,
		selection_caret = "* ",
		selection_strategy = "reset",
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		path_display = {},
		sorting_strategy = "descending",
		use_less = true,
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		winblend = 0,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
	},
	-- Specific config
	pickers = {
		buffers = {
			sort_lastused = true,
			-- theme = "dropdown",
		},
		find_files = {
		},
	},
	extensions = {
	}
}

-- Auto Completion
require'compe'.setup {
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;
	documentation = true;

	source = {
		path = true;
		nvim_lsp = true;
		buffer = true;
		calc = true;
		spell = true;
		tags = true;
		emoji = true;
		-- vsnip = true;
		ultisnips = true;
		-- luasnip = true;
	};
}

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-n>"
	elseif check_back_space() then
		return t "<Tab>"
	else
		return vim.fn['compe#complete']()
	end
end
_G.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t "<C-p>"
	else
		return t "<S-Tab>"
	end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {noremap = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", {noremap = true, expr = true})

vim.opt.completeopt = "menuone,noselect"

-- Auto Format

--autocmd BufWritePre *.js *.py *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
-- vim.cmd(
--	[[
--	au BufWrite * :Autoformat autocmd FileType txt,tex,text,yaml,yml,md,markdown let b:autoformat_autoindent=0
--	autocmd FileType md,markdown let b:autoformat_retab=0
--	]]
-- )

-- Align Stuff
-- Start interactive EasyAlign in visual mode (e.g. vipga)
vim.api.nvim_set_keymap('x',"ga", [[<Plug>(EasyAlign)]], {})

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.api.nvim_set_keymap('n',"ga", [[<Plug>(EasyAlign)]], {})

-- LuaLine
-- In colorscheme

-- UltiSnips
-- Default config

-- vim.g.UltiSnipsExpandTrigger="<c-tab>"
vim.g.UltiSnipsJumpForwardTrigger="<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger="<S-Tab>"

-- Nvim-tree

-- left by default
vim.g.nvim_tree_side = 'left'

-- 30 by default, can be width_in_columns or 'width_in_percent%'
vim.g.nvim_tree_width = "15%"

-- empty by default
vim.g.nvim_tree_ignore = {
	'.git',
	'node_modules',
	'*cache*',
}

-- 0 by default
vim.g.nvim_tree_gitignore = 1

-- 0 by default, opens the tree when typing `vim $DIR` or `vim`
vim.g.nvim_tree_auto_open = 1

-- 0 by default, closes the tree when it's the last window
vim.g.nvim_tree_auto_close = 1

-- empty by default, don't auto open tree on specific filetypes.
vim.g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' }

-- 0 by default, closes the tree when you open a file
vim.g.nvim_tree_quit_on_open = 1

-- 0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_follow = 1

-- 0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_indent_markers = 1

-- 0 by default, this option hides files and folders starting with a dot `.`
vim.g.nvim_tree_hide_dotfiles = 1

-- 0 by default, will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_git_hl = 1

-- 0 by default, will enable folder and file icon highlight for opened files/directories.
vim.g.nvim_tree_highlight_opened_files = 1

--This is the default. See :help filename- modifiers for more options
vim.g.nvim_tree_root_folder_modifier = ':~'

-- 0 by default, will open the tree when entering a new tab and the tree was previously open
vim.g.nvim_tree_tab_open = 1

-- 1 by default, will resize the tree to its saved width when opening a file
vim.g.nvim_tree_auto_resize = 0

-- 1 by default, disables netrw
vim.g.nvim_tree_disable_netrw = 1

-- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
vim.g.nvim_tree_hijack_netrw = 1

-- 0 by default, append a trailing slash to folder names
vim.g.nvim_tree_add_trailing = 0

--  0 by default, compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_group_empty = 1

-- 0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
vim.g.nvim_tree_lsp_diagnostics = 1

-- 0 by default, will disable the window picker.
vim.g.nvim_tree_disable_window_picker = 0

-- 1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
vim.g.nvim_tree_hijack_cursor = 0

-- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
vim.g.nvim_tree_icon_padding = ' '

-- 0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
vim.g.nvim_tree_update_cwd = 1

vim.g.nvim_tree_window_picker_exclude = {
	filetype =  {
		'packer',
		'qf'
	},
	buftype =  {
		'terminal'
	}
}
-- Dictionary of buffer option names mapped to a list of option values that
-- indicates to the window picker that the buffer's window should not be
-- selectable.
vim.g.nvim_tree_special_files = { -- List of filenames that gets highlighted with NvimTreeSpecialFile
	["README.md"] = 1,
	Makefile = 1,
	MAKEFILE =  1
}

-- If 0, do not show the icons for one of 'git' 'folder' and 'files'
-- 1 by default, notice that if 'files' is 1, it will only display
-- if nvim-web-devicons is installed and on your runtimepath.
-- if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
-- but this will not work when you set indent_markers (because of UI conflict)
vim.g.nvim_tree_show_icons = {
	git =  1,
	folders =  1,
	files =  1,
	folder_arrows =  1,
}

--  default will show icon by default if no icon is provided
--  default shows no icon by default
vim.g.nvim_tree_icons = {
	default =  '',
	symlink =  '',
	git =  {
		unstaged =  "✗",
		staged =  "✓",
		unmerged =  "",
		renamed =  "➜",
		untracked =  "★",
		deleted =  "",
		ignored =  "◌"
	},
	folder =  {
		arrow_open =  "",
		arrow_closed =  "",
		default =  "",
		open =  "",
		empty =  "",
		empty_open =  "",
		symlink =  "",
		symlink_open =  "",
	},
	lsp =  {
		hint =  "",
		info =  "",
		warning =  "",
		error =  "",
	}
}

-- Open the node under the cursor with the OS default application (usually file explorer for folders):
function NvimTreeOSOpen()
	local lib = require("nvim-tree.lib")
	local node = lib.get_node_at_cursor()
	if node then
		vim.fn.jobstart("xdg-open '" .. node.absolute_path .. "' &", {detach = true})
	end
end

-- Open Nvim-tree
vim.api.nvim_set_keymap('', "<C-f>", ":NvimTreeToggle<CR>", {silent = true, noremap = true})

-- On nvim-tree keybindings
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
	-- default mappings
	{ key = {"l", "<CR>", "o", "<2-LeftMouse>"},	cb = tree_cb("edit") },
	{ key = {"L", "<2-RightMouse>", "<C-]>"},		cb = tree_cb("cd") },
	{ key = "s",									cb = tree_cb("vsplit") },
	{ key = "v",									cb = tree_cb("split") },
	{ key = "t",									cb = tree_cb("tabnew") },
	{ key = "<",									cb = tree_cb("prev_sibling") },
	{ key = ">",									cb = tree_cb("next_sibling") },
	{ key = "P",									cb = tree_cb("parent_node") },
	{ key = {"h", "<BS>"},							cb = tree_cb("close_node") },
	{ key = "<Tab>",								cb = tree_cb("preview") },
	{ key = "K",									cb = tree_cb("first_sibling") },
	{ key = "J",									cb = tree_cb("last_sibling") },
	{ key = "i",									cb = tree_cb("toggle_dotfiles") },
	{ key = "I",									cb = tree_cb("toggle_ignored") },
	{ key = "R",									cb = tree_cb("refresh") },
	{ key = "a",									cb = tree_cb("create") },
	{ key = "d",									cb = tree_cb("remove") },
	{ key = "r",									cb = tree_cb("rename") },
	{ key = "<C-r>",								cb = tree_cb("full_rename") },
	{ key = "x",									cb = tree_cb("cut") },
	{ key = "c",									cb = tree_cb("copy") },
	{ key = "p",									cb = tree_cb("paste") },
	{ key = "y",									cb = tree_cb("copy_name") },
	{ key = "Y",									cb = tree_cb("copy_path") },
	{ key = "gy",									cb = tree_cb("copy_absolute_path") },
	{ key = "[c",									cb = tree_cb("prev_git_item") },
	{ key = "]c",									cb = tree_cb("next_git_item") },
	{ key = {"H", "-" },							cb = tree_cb("dir_up") },
	{ key = "q",									cb = tree_cb("close") },
	{ key = "g?",									cb = tree_cb("toggle_help") },
	{ key = {"<C-l>", "<C-CR>"},					cb = ":lua NvimTreeOSOpen()<CR>" },
}

-- CoC complatible config
vim.g.UltiSnipsExpandTrigger = '<Nop>'
-- vim.g.coc_snippet_next = '<C-n>'
-- vim.g.coc_snippet_prev = '<C-b>'
-- vim.api.nvim_set_keymap('i', "<C-Tab>", "<Plug>(coc-snippets-expand)", {})

vim.g.UltiSnipsEditSplit = "vertical"


-- Markdown Preview:

-- set to 1, nvim will open the preview window after entering the markdown buffer
-- default: 0
-- vim.g.mkdp_auto_start = 1

-- set to 1, the nvim will auto close current preview window when change
-- from markdown buffer to another buffer
-- default: 1
vim.g.mkdp_auto_close = 1

-- set to 1, the vim will refresh markdown when save the buffer or
-- leave from insert mode, default 0 is auto refresh markdown as you edit or
-- move the cursor
-- default: 0
vim.g.mkdp_refresh_slow = 0

-- set to 1, the MarkdownPreview command can be use for all files,
-- by default it can be use in markdown file
-- default: 0
vim.g.mkdp_command_for_global = 1

-- set to 1, preview server available to others in your network
-- by default, the server listens on localhost (127.0.0.1)
-- default: 0
vim.g.mkdp_open_to_the_world = 0

-- use custom IP to open preview page
-- useful when you work in remote vim and preview on local browser
-- more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
-- default empty
vim.g.mkdp_open_ip = ''

-- specify browser to open preview page
-- default: ''
vim.g.mkdp_browser = 'qutebrowser'

-- set to 1, echo preview page url in command line when open preview page
-- default is 0
vim.g.mkdp_echo_preview_url = 1

-- a custom vim function name to open preview page
-- this function will receive url as param
-- default is empty
vim.g.mkdp_browserfunc = ''

-- options for markdown render
-- mkit: markdown-it options for render
-- katex: katex options for math
-- uml: markdown-it-plantuml options
-- maid: mermaid options
-- disable_sync_scroll: if disable sync scroll, default 0
-- sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
--   middle: mean the cursor position alway show at the middle of the preview page
--   top: mean the vim top viewport alway show at the top of the preview page
--   relative: mean the cursor position alway show at the relative positon of the preview page
-- hide_yaml_meta: if hide yaml metadata, default is 1
-- sequence_diagrams: js-sequence-diagrams options
-- content_editable: if enable content editable for preview page, default: v:false
-- disable_filename: if disable filename header for preview page, default: 0
-- vim.cmd([[
-- let g:mkdp_preview_options = {
--             \ 'mkit': {},
--             \ 'katex': {},
--             \ 'uml': {},
--             \ 'maid': {},
--             \ 'disable_sync_scroll': 0,
--             \ 'sync_scroll_type': 'relative',
--             \ 'hide_yaml_meta': 1,
--             \ 'sequence_diagrams': {},
--             \ 'flowchart_diagrams': {},
--             \ 'content_editable': v:false,
--             \ 'disable_filename': 0
--             \ }
-- ]])

-- use a custom markdown style must be absolute path
-- like '/Users/username/markdown.css' or expand('~/markdown.css')
vim.g.mkdp_markdown_css = ''

-- use a custom highlight style must absolute path
-- like '/Users/username/highlight.css' or expand('~/highlight.css')
vim.g.mkdp_highlight_css = ''

-- use a custom port to start server or random for empty
vim.g.mkdp_port = ''

-- preview page title
-- ${name} will be replace with the file name
vim.g.mkdp_page_title = '「${name}」'

-- recognized filetypes
-- these filetypes will have MarkdownPreview... commands
vim.g.mkdp_filetypes = {'markdown', 'md', 'vimwiki'}

-- Indent Lines
vim.g.indent_blankline_char_list = {
	"│",
}
vim.g.indentLine_enabled = 1
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard", "nvim-tree"}
vim.g.indent_blankline_buftype_exclude = {"terminal"}
vim.g.indent_blankline_show_first_indent_level = false

-- Color Highlight
vim.opt.termguicolors = true
require'colorizer'.setup()

-- Dashboard

-- Default FZF
vim.g.dashboard_default_executive = "telescope"

-- Custom Shortcuts
vim.api.nvim_set_keymap('n', '<Leader>db', ":DashboardJumpMark<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dh', ":DashboardFindHistory<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>df', ":DashboardFindFile<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dn', ":DashboardNewFile<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>da', ":DashboardFindWord<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dc', ":DashboardChangeColorscheme<CR>", { silent = true })

-- Show mappings
vim.g.dashboard_custom_shortcut={
	last_session =			 'SPC s l',
	book_marks =			 'SPC d b',
	find_history =			 'SPC d h',
	find_file =				 'SPC d f',
	new_file =				 'SPC d n',
	find_word =				 'SPC d a',
	change_colorscheme =	 'SPC d c',
}

-- Hide tabline on dashboard
vim.cmd(
	[[
	autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
	]]
)

-- Cheetsheet.nvim
require("cheatsheet").setup({
	-- Whether to show bundled cheatsheets

	-- For generic cheatsheets like default, unicode, nerd-fonts, etc
	-- bundled_cheatsheets = true,
	bundled_cheatsheets = {
		enabled = {
			"default",
			"regex",
			"markdown",
			-- "unicode",
			-- "nerd-fonts",
		},
	},

	-- For plugin specific cheatsheets
bundled_plugin_cheatsheets = true,
-- bundled_plugin_cheatsheets = {
	--     enabled = {},
	--     disabled = {},
	-- }

	-- For bundled plugin cheatsheets, do not show a sheet if you
	-- don't have the plugin installed (searches runtimepath for
	-- same directory name)
	include_only_installed_plugins = true,
})

vim.opt.timeoutlen = 500
require("which-key").setup{
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

-- vim repeat (need to be after plugin config)
vim.cmd([[silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)]])
