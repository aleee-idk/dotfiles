-- Current colorscheme
lvim.colorscheme = "base16-material-palenight"
lvim.transparent_window = true

local header_text = "aleidk"
local header_font = "DOS Rebel"

-- Dracula Config

-- Tokyonight Config
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_variables = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_transparent = true

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Tokyodark Config
vim.g.tokyodark_transparent_background = true
vim.g.tokyodark_enable_italic_comment = true
vim.g.tokyodark_enable_italic = true
vim.g.tokyodark_color_gamma = "1.0"

-- Onedark Config
vim.g.onedark_style = "deep"

-- Moonlight Config
vim.g.moonlight_italic_comments = true
-- vim.g.moonlight_italic_keywords = true
vim.g.moonlight_italic_functions = true
vim.g.moonlight_italic_variables = false
-- vim.g.moonlight_contrast = true
vim.g.moonlight_borders = false
vim.g.moonlight_disable_background = true

-- Neon Config
vim.g.neon_style = "dark"
vim.g.neon_italic_keyword = true
vim.g.neon_italic_function = true
vim.g.dark_disable_background = true

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

-- Alternatively, you can provide a table specifying your colors to the setup function.
require("base16-colorscheme").setup({
	-- Start flavours
	-- Base16 Porple
	-- Author: Niek den Breeje (https://github.com/AuditeMarlow)
	-- to be use with https://github.com/RRethy/nvim-base16

	base00 = "#292c36",
	base01 = "#333344",
	base02 = "#474160",
	base03 = "#65568a",
	base04 = "#b8b8b8",
	base05 = "#d8d8d8",
	base06 = "#e8e8e8",
	base07 = "#f8f8f8",
	base08 = "#f84547",
	base09 = "#d28e5d",
	base0A = "#efa16b",
	base0B = "#95c76f",
	base0C = "#64878f",
	base0D = "#8485ce",
	base0E = "#b74989",
	base0F = "#986841",
	-- End flavours
})
