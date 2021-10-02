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
	local actions = require("telescope.actions")

	-- Mappings

	-- for input mode
	telescope_config.mappings.i["<C-j>"] = actions.move_selection_next
	telescope_config.mappings.i["<C-k>"] = actions.move_selection_previous
	telescope_config.mappings.i["<C-n>"] = actions.cycle_history_next
	telescope_config.mappings.i["<C-p>"] = actions.cycle_history_prev
	telescope_config.mappings.i["<C-s>"] = actions.file_vsplit
	telescope_config.mappings.i["<C-v>"] = actions.file_split
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

local nvim_tree = lvim.builtin.nvimtree
-- left by default
nvim_tree.side = "left"

-- 30 by default, can be width_in_columns or 'width_in_percent%'
nvim_tree.width = 30

-- empty by default
nvim_tree.ignore = { ".git", "node_modules", "*cache*" }

-- 0 by default
nvim_tree.gitignore = 1

-- 0 by default, opens the tree when typing `vim $DIR` or `vim`
nvim_tree.auto_open = 1

-- 0 by default, closes the tree when it's the last window
nvim_tree.auto_close = 1

-- empty by default, don't auto open tree on specific filetypes.
nvim_tree.auto_ignore_ft = { "startify", "dashboard" }

-- 0 by default, closes the tree when you open a file
nvim_tree.quit_on_open = 1

-- 0 by default, this option allows the cursor to be updated when entering a buffer
nvim_tree.follow = 1

-- 0 by default, this option shows indent markers when folders are open
nvim_tree.indent_markers = 1

-- 0 by default, this option hides files and folders starting with a dot `.`
nvim_tree.hide_dotfiles = 1

-- 0 by default, will enable file highlight for git attributes (can be used without the icons).
nvim_tree.git_hl = 1

-- 0 by default, will enable folder and file icon highlight for opened files/directories.
nvim_tree.highlight_opened_files = 1

-- This is the default. See :help filename- modifiers for more options
nvim_tree.root_folder_modifier = ":~"

-- 0 by default, will open the tree when entering a new tab and the tree was previously open
nvim_tree.tab_open = 1

-- 1 by default, will resize the tree to its saved width when opening a file
nvim_tree.auto_resize = 0

-- 1 by default, disables netrw
nvim_tree.disable_netrw = 1

-- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
nvim_tree.hijack_netrw = 1

-- 0 by default, append a trailing slash to folder names
nvim_tree.add_trailing = 0

--  0 by default, compact folders that only contain a single folder into one node in the file tree
nvim_tree.group_empty = 1

-- 0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
nvim_tree.lsp_diagnostics = 1

-- 0 by default, will disable the window picker.
nvim_tree.disable_window_picker = 0

-- 1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
nvim_tree.hijack_cursor = 0

-- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
nvim_tree.icon_padding = " "

-- 0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.

-- This 2 are needed for project.nvim
nvim_tree.update_cwd = 1
nvim_tree.respect_buf_cwd = 1

nvim_tree.window_picker_exclude = {
	filetype = { "packer", "qf" },
	buftype = { "terminal" },
}
-- Dictionary of buffer option names mapped to a list of option values that
-- indicates to the window picker that the buffer's window should not be
-- selectable.
nvim_tree.special_files = { -- List of filenames that gets highlighted with NvimTreeSpecialFile
	["README.md"] = 1,
	Makefile = 1,
	MAKEFILE = 1,
}

-- If 0, do not show the icons for one of 'git' 'folder' and 'files'
-- 1 by default, notice that if 'files' is 1, it will only display
-- if nvim-web-devicons is installed and on your runtimepath.
-- if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
-- but this will not work when you set indent_markers (because of UI conflict)
nvim_tree.show_icons = {
	git = 1,
	folders = 1,
	files = 1,
	folder_arrows = 1,
}

--  default will show icon by default if no icon is provided
--  default shows no icon by default
nvim_tree.icons = {
	default = "",
	symlink = "",
	git = {
		unstaged = "✗",
		staged = "✓",
		unmerged = "",
		renamed = "➜",
		untracked = "★",
		deleted = "",
		ignored = "◌",
	},
	folder = {
		arrow_open = "",
		arrow_closed = "",
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "",
		symlink_open = "",
	},
	lsp = { hint = "", info = "", warning = "", error = "" },
}

-- Open the node under the cursor with the OS default application (usually file explorer for folders):
function NvimTreeOSOpen()
	local lib = require("nvim-tree.lib")
	local node = lib.get_node_at_cursor()
	if node then
		vim.fn.jobstart("xdg-open '" .. node.absolute_path .. "' &", { detach = true })
	end
end

-- bindings
lvim.keys.normal_mode["<C-f>"] = ":NvimTreeToggle<CR>"
local tree_cb = require("nvim-tree.config").nvim_tree_callback
nvim_tree.bindings = {
	-- default mappings
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
	{ key = { "<C-l>", "<C-CR>" }, cb = ":lua NvimTreeOSOpen()<CR>" },
}

----------------------------------------------------------------------
--                             Terminal                             --
----------------------------------------------------------------------

local term = lvim.builtin.terminal
term.direction = "horizontal"

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
