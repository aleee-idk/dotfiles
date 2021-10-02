require("sidebar-nvim").setup({
	disable_default_keybindings = 0,
	bindings = nil,
	open = false,
	side = "right",
	initial_width = 35,
	update_interval = 1000,
	sections = { "git-status", "lsp-diagnostics", "todos" },
	section_separator = "-----",
})
