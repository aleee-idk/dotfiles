require("sidebar-nvim").setup({
	disable_default_keybindings = 0,
	bindings = nil,
	open = false,
	side = "right",
	initial_width = 30,
	hide_statusline = false,
	update_interval = 1000,
	sections = { "git", "diagnostics", "symbols", "todos", "buffers" },
	section_separator = "-----",
	containers = {
		attach_shell = "/bin/sh",
		show_all = true,
		interval = 5000,
	},
	datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
	todos = { ignored_paths = { "~" } },
	disable_closing_prompt = false,
})

vim.api.nvim_set_keymap("n", "<C-g>", ":SidebarNvimToggle<CR>", { noremap = true, silent = true })
