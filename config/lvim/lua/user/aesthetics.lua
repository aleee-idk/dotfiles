-- Current colorscheme
vim.g.catppuccin_flavour = "frappe"
lvim.colorscheme = "catppuccin"
-- lvim.transparent_window = true

-- Color Scheme
local catppuccin = require("catppuccin")

-- configure it
catppuccin.setup({
	transparent_background = true,
	term_colors = false,
	styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {"italic"},
    functions = {"italic"},
    keywords = {"italic"},
    strings = {"italic"},
    variables = {"italic"},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
			},
			underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
			},
		},
		lsp_trouble = true,
		cmp = true,
		lsp_saga = true,
		gitgutter = false,
		gitsigns = true,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = true,
      transparent_panel = true,
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
    neotree = {
      enabled = false,
      show_root = true,
      transparent_panel = false,
    },
    dap = {
      enabled = false,
      enable_ui = false,
    },
		which_key = true,
		dashboard = true,
		neogit = false,
		vim_sneak = false,
		fern = false,
		barbar = true,
		bufferline = true,
		markdown = true,
		lightspeed = false,
		ts_rainbow = true,
		hop = false,
		notify = true,
		telekasten = true,
    symbols_outline = true,
    mini = false,
	},
})


lvim.builtin.lualine.theme = lvim.colorscheme
lvim.builtin.lualine.component_separators = { "", "" }
lvim.builtin.lualine.section_separators = { "", "" }
lvim.builtin.lualine.sections = {
	lualine_a = { "mode" },
	lualine_b = { "branch" },
	lualine_c = { "filename" },
	lualine_x = { "filetype" },
	lualine_y = { "progress" },
	lualine_z = { "location" },
}
lvim.builtin.lualine.inactive_sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = { "filename" },
	lualine_x = { "location" },
	lualine_y = {},
	lualine_z = {},
}
lvim.builtin.lualine.tabline = {}
lvim.builtin.lualine.extensions = { "nvim-tree" }
