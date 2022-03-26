-----------------------------------------------------------------------
--                      Buildin plugins Status                      --
----------------------------------------------------------------------

-- enable
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.autopairs.active = true
lvim.builtin.bufferline.active = true
lvim.builtin.dap.active = true
lvim.builtin.notify.active = true

-- disable

----------------------------------------------------------------------
--                            Treesitter                            --
----------------------------------------------------------------------

local treesitter = lvim.builtin.treesitter

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.http = {
	install_info = {
		url = "https://github.com/NTBBloodbath/tree-sitter-http",
		files = { "src/parser.c" },
		branch = "main",
	},
}

-- if you don't want all the parsers change this to a table of the ones you want
treesitter.ensure_installed = {
	"bash",
	"css",
	"dockerfile",
	"fish",
	"html",
	"http",
	"javascript",
	"json",
	"lua",
	"python",
	"scss",
	"toml",
	"tsx",
	"typescript",
	"yaml",
	"dart",
}
treesitter.ignore_install = {}
treesitter.highlight.enabled = true
treesitter.rainbow.enable = true
treesitter.autotag.enable = true

vim.cmd([[set foldmethod=expr]])
vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])

----------------------------------------------------------------------
--                            Telescope                             --
----------------------------------------------------------------------

local actions = require("telescope.actions")

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
lvim.builtin.telescope.on_config_done = function()
	local telescope_config = lvim.builtin.telescope.defaults

	telescope_config.mappings.i["<C-j>"] = actions.move_selection_next
	telescope_config.mappings.i["<C-k>"] = actions.move_selection_previous
	telescope_config.mappings.i["<C-n>"] = actions.cycle_history_next
	telescope_config.mappings.i["<C-p>"] = actions.cycle_history_prev
	telescope_config.mappings.i["<C-s>"] = actions.file_vsplit
	telescope_config.mappings.i["<C-v>"] = actions.file_split
	telescope_config.mappings.i["<esc>"] = actions.close
	-- for normal mode
	telescope_config.mappings.n["j"] = actions.move_selection_next
	telescope_config.mappings.n["k"] = actions.move_selection_previous
	telescope_config.mappings.n["n"] = actions.cycle_history_next
	telescope_config.mappings.n["p"] = actions.cycle_history_prev
	telescope_config.mappings.n["s"] = actions.file_vsplit
	telescope_config.mappings.n["v"] = actions.file_split

	-- Other configs
	telescope_config.prompt_prefix = "> "
	telescope_config.selection_caret = "* "
	telescope_config.scroll_strategy = nil
	telescope_config.file_ignore_patterns = { "%.env", "cache", ".xlsx" }

	lvim.builtin.telescope.pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
		},
	}
	-- Extensions
	lvim.builtin.telescope.extensions = {
		extensions = {
			media_files = {
				-- filetypes whitelist
				-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
				filetypes = { "png", "webp", "jpg", "jpeg" },
				find_cmd = "rg", -- find command (defaults to `fd`)
			},
		},
	}
end

lvim.builtin.which_key.mappings["sp"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["sy"] = { "<cmd>lua require'telescope'.extensions.neoclip.default()<CR>", "Neoclip" }
lvim.builtin.which_key.mappings["sy"] = { "<cmd>lua require'telescope'.extensions.neoclip.default()<CR>", "Neoclip" }
lvim.builtin.which_key.mappings["sT"] = { "<cmd>TodoTelescope<CR>", "TODO" }

----------------------------------------------------------------------
--                            Nvim-Tree                             --
----------------------------------------------------------------------

lvim.builtin.nvimtree.quit_on_open = 1
lvim.builtin.nvimtree.git_hl = 1
lvim.builtin.nvimtree.highlight_opened_files = 1
lvim.builtin.nvimtree.add_trailing = 1
lvim.builtin.nvimtree.group_empty = 1

-- bindings
lvim.keys.normal_mode["<C-f>"] = ":NvimTreeToggle<CR>"
local tree_cb = require("nvim-tree.config").nvim_tree_callback

lvim.builtin.nvimtree.setup = {
	-- disables netrw completely
	disable_netrw = true,
	-- hijack netrw window on startup
	hijack_netrw = true,
	-- open the tree when running this setup function
	open_on_setup = false,
	-- will not open on setup if the filetype is in this list
	ignore_ft_on_setup = {},
	-- closes neovim automatically when the tree is the last **WINDOW** in the view
	auto_close = true,
	-- opens the tree when changing/opening a new tab if the tree wasn't previously opened
	open_on_tab = false,
	-- close when open a file
	quit_on_open = true,
	-- hijacks new directory buffers when they are opened.
	update_to_buf_dir = {
		-- enable the feature
		enable = true,
		-- allow to open the tree if it was previously closed
		auto_open = true,
	},
	-- hijack the cursor in the tree to put it at the start of the filename
	hijack_cursor = false,
	-- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
	update_cwd = false,
	-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	update_focused_file = {
		-- enables the feature
		enable = true,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		update_cwd = false,
		-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
		-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
		ignore_list = {},
	},
	-- configuration options for the system open command (`s` in the tree by default)
	system_open = {
		-- the command to run this, leaving nil should work in most cases
		cmd = nil,
		-- the command arguments as a list
		args = {},
	},
	filters = {
		dotfiles = true,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		-- width of the window, can be either a number (columns) or a string in `%`
		width = 30,
		-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		side = "left",
		-- if true the tree will resize itself after opening a file
		auto_resize = true,
		mappings = {
			-- custom only false will merge the list with the default mappings
			-- if true, it will only use your list to set the mappings
			custom_only = false,
			-- list of mappings to set on the tree manually
			list = {
				{ key = { "l", "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb("edit") },
				{ key = { "L", "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
				{ key = "s", cb = tree_cb("vsplit") },
				{ key = "v", cb = tree_cb("split") },
				{ key = "t", cb = tree_cb("tabnew") },
				{ key = "<", cb = tree_cb("prev_sibling") },
				{ key = ">", cb = tree_cb("next_sibling") },
				{ key = "P", cb = tree_cb("parent_node") },
				{ key = { "h", "<BS>" }, cb = tree_cb("close_node") },
				{ key = "<Tab>", cb = tree_cb("preview") },
				{ key = "K", cb = tree_cb("first_sibling") },
				{ key = "J", cb = tree_cb("last_sibling") },
				{ key = "i", cb = tree_cb("toggle_dotfiles") },
				{ key = "I", cb = tree_cb("toggle_ignored") },
				{ key = "R", cb = tree_cb("refresh") },
				{ key = "a", cb = tree_cb("create") },
				{ key = "d", cb = tree_cb("remove") },
				{ key = "r", cb = tree_cb("rename") },
				{ key = "<C-r>", cb = tree_cb("full_rename") },
				{ key = "x", cb = tree_cb("cut") },
				{ key = "c", cb = tree_cb("copy") },
				{ key = "p", cb = tree_cb("paste") },
				{ key = "y", cb = tree_cb("copy_name") },
				{ key = "Y", cb = tree_cb("copy_path") },
				{ key = "gy", cb = tree_cb("copy_absolute_path") },
				{ key = "[c", cb = tree_cb("prev_git_item") },
				{ key = "]c", cb = tree_cb("next_git_item") },
				{ key = { "H", "-" }, cb = tree_cb("dir_up") },
				{ key = "q", cb = tree_cb("close") },
				{ key = "g?", cb = tree_cb("toggle_help") },
				{ key = { "<C-l>", "<C-CR>" }, cb = tree_cb("system_open") },
			},
		},
	},
}

----------------------------------------------------------------------
--                             Terminal                             --
----------------------------------------------------------------------

----------------------------------------------------------------------
--                            Bufferline                            --
----------------------------------------------------------------------

lvim.builtin.bufferline.options = {
	-- Enable/disable animations
	animation = true,

	-- Enable/disable auto-hiding the tab bar when there is a single buffer
	auto_hide = true,

	-- Enable/disable current/total tabpages indicator (top right corner)
	tabpages = true,

	-- Enable/disable close button
	closable = true,

	-- Enables/disable clickable tabs
	--  - left-click: go to buffer
	--  - middle-click: delete buffer
	clickable = true,

	-- Excludes buffers from the tabline
	exclude_ft = {},
	exclude_name = {},

	-- Enable/disable icons
	-- if set to 'numbers', will show buffer index in the tabline
	-- if set to 'both', will show buffer index and icons in the tabline
	icons = true,

	-- If set, the icon color will follow its corresponding buffer
	-- highlight group. By default, the Buffer*Icon group is linked to the
	-- Buffer* group (see Highlighting below). Otherwise, it will take its
	-- default value as defined by devicons.
	icon_custom_colors = false,

	-- Configure icons on the bufferline.
	icon_separator_active = "▎",
	icon_separator_inactive = "▎",
	icon_close_tab = "",
	icon_close_tab_modified = "●",
	icon_pinned = "車",

	-- If true, new buffers will be inserted at the start/end of the list.
	-- Default is to insert after current buffer.
	insert_at_end = false,
	insert_at_start = false,

	-- Sets the maximum padding width with which to surround each tab
	maximum_padding = 1,

	-- Sets the maximum buffer name length.
	maximum_length = 30,

	-- If set, the letters for each buffer in buffer-pick mode will be
	-- assigned based on their name. Otherwise or in case all letters are
	-- already assigned, the behavior is to assign letters in order of
	-- usability (see order below)
	semantic_letters = true,

	-- New buffer letters are assigned in this order. This order is
	-- optimal for the qwerty keyboard layout but might need adjustement
	-- for other layouts.
	letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

	-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
	-- where X is the buffer number. But only a static string is accepted here.
	no_name_title = nil,
}

----------------------------------------------------------------------
--                             Debugger                             --
----------------------------------------------------------------------

local dap_install = require("dap-install")
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger)
end

local dap = require("dap")
dap.configurations.javascript = {
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

----------------------------------------------------------------------
--                            Dashboard                             --
----------------------------------------------------------------------

lvim.builtin.dashboard.custom_section = {
	a = {
		description = { "  Recent Projects    " },
		command = "Telescope projects",
	},
	b = {
		description = { "  Find File          " },
		command = "Telescope find_files",
	},
	c = {
		description = { "  New File           " },
		command = ":ene!",
	},
	d = {
		description = { "  Recently Used Files" },
		command = "Telescope oldfiles",
	},
	e = {
		description = { "  Find Word          " },
		command = "Telescope live_grep",
	},
}

----------------------------------------------------------------------
--                            Completion                            --
----------------------------------------------------------------------

require("luasnip").filetype_extend("dart", { "flutter" })
