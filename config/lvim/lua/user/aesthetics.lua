-- Current colorscheme
lvim.colorscheme = "catppuccin"
-- lvim.transparent_window = true

local header_text = "aleidk"
local header_font = "DOS Rebel"

-- Color Scheme
local catppuccin = require("catppuccin")

-- configure it
catppuccin.setup({
	transparent_background = true,
	term_colors = false,
	styles = {
		comments = "italic",
		functions = "italic",
		keywords = "italic",
		strings = "NONE",
		variables = "bold",
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = "italic",
				hints = "italic",
				warnings = "italic",
				information = "italic",
			},
			underlines = {
				errors = "underline",
				hints = "underline",
				warnings = "underline",
				information = "underline",
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
		},
		which_key = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
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

-- Set Dashboard Header
local file = io.popen([[figlet -f "]] .. header_font .. [[" ]] .. header_text)
local lines = {}
for line in file:lines() do
	lines[#lines + 1] = line
end

lvim.builtin.dashboard.custom_header = lines
