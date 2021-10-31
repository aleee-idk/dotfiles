-----------------------------------------------------------------------
--                      Buildin plugins Status                      --
----------------------------------------------------------------------

-- enable
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.autopairs.active = true
lvim.builtin.bufferline.active = true
lvim.builtin.dap.active = true

-- disable

----------------------------------------------------------------------
--                            Treesitter                            --
----------------------------------------------------------------------

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.http = {
	install_info = {
		url = "https://github.com/NTBBloodbath/tree-sitter-http",
		files = { "src/parser.c" },
		branch = "main",
	},
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"css",
	"dockerfile",
	"fish",
	"html",
	"json",
	"lua",
	"python",
	"scss",
	"toml",
	"typescript",
	"yaml",
	"http",
}
lvim.builtin.treesitter.ignore_install = {}
lvim.builtin.treesitter.highlight.enabled = true

----------------------------------------------------------------------
--                            Telescope                             --
----------------------------------------------------------------------

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
lvim.builtin.telescope.on_config_done = function()
	local telescope_config = lvim.builtin.telescope.defaults

	-- telescope_config.mappings.i["<C-j>"] = actions.move_selection_next
	-- telescope_config.mappings.i["<C-k>"] = actions.move_selection_previous
	-- telescope_config.mappings.i["<C-n>"] = actions.cycle_history_next
	-- telescope_config.mappings.i["<C-p>"] = actions.cycle_history_prev
	-- telescope_config.mappings.i["<C-s>"] = actions.file_vsplit
	-- telescope_config.mappings.i["<C-v>"] = actions.file_split
	-- -- for normal mode
	-- telescope_config.mappings.n["j"] = actions.move_selection_next
	-- telescope_config.mappings.n["k"] = actions.move_selection_previous
	-- telescope_config.mappings.n["n"] = actions.cycle_history_next
	-- telescope_config.mappings.n["p"] = actions.cycle_history_prev
	-- telescope_config.mappings.n["s"] = actions.file_vsplit
	-- telescope_config.mappings.n["v"] = actions.file_split

	-- Other configs
	telescope_config.prompt_prefix = "> "
	telescope_config.selection_caret = "* "
	telescope_config.scroll_strategy = nil
	telescope_config.file_ignore_patterns = { "%.env", "cache", ".xlsx" }

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
lvim.builtin.nvimtree.hide_dotfiles = 1
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
		enable = false,
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

vim.g.bufferline = {
	animation = true,
	auto_hide = true,
	tabpage = true,
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
