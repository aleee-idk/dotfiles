local yabs = require("yabs")

yabs:setup({
	languages = { -- List of languages in vim `filetype` format
		lua = {
			tasks = {
				run = {
					command = "luafile %", -- The cammand to run (% and other
					-- wildcards will be automatically
					-- expanded)
					type = "vim", -- The type of command (can be `vim`, `lua`, or
					-- `shell`, default `shell`)
				},
			},
		},
		javascriptreact = {
			default_task = "run",
			tasks = {
				run = {
					command = "cd $(git rev-parse --show-toplevel) && BROWSER=$DEV_BROWSER yarn start",
					output = "quickfix",
				},
				test = {
					command = "cd $(gir rev-parse --show-toplevel) && yarn test -- --coverage --watchAll=false",
					output = "quickfix",
					type = "quickfix",
				},
				build = {
					command = "cd $(git rev-parse --show-toplevel) && yarn build",
					output = "quickfix",
				},
			},
		},
	},
	tasks = { -- Same values as `language.tasks`, but global
		build = {
			command = "echo building project...",
			output = "consolation",
		},
		run = {
			command = "echo running project..",
			output = "echo",
		},
		prueba = {
			command = "pwd",
			output = "quickfix",
			type = "shell",
		},
	},
	opts = { -- Same values as `language.opts`
		output_types = {
			quickfix = {
				open_on_run = "always",
			},
		},
	},
})

vim.api.nvim_set_keymap("n", "<F1>", [[:lua require("yabs"):run_default_task()<CR>]], {
	noremap = true,
	silent = true,
})
vim.api.nvim_set_keymap("n", "<F2>", [[:lua require("yabs"):run_task("run")<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F3>", [[:lua require("yabs"):run_task("test")<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F4>", [[:lua require("yabs"):run_task("build")<CR>]], { noremap = true, silent = true })
