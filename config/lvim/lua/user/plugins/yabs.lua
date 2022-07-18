local yabs = require("yabs")
local Terminal = require("toggleterm.terminal").Terminal

local run_term = nil

function TOGGLE_RUN(cmd)
	if run_term == nil then
		run_term = Terminal:new({
			cmd = cmd,
			count = 7,
			start_in_insert = false,
			close_on_exit = false,
		})
	end
	run_term:toggle()
end

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
		typescriptreact = {
			default_task = "run",
			tasks = {
				run = {
					command = "export BROWSER=firefox-developer-edition && yarn start",
					output = TOGGLE_RUN,
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
		javascriptreact = {
			default_task = "run",
			tasks = {
				run = {
					command = "export BROWSER=firefox-developer-edition && yarn start",
					output = TOGGLE_RUN,
				},
				run_dev = {
					command = "export BROWSER=firefox-developer-edition && yarn dev",
					output = TOGGLE_RUN,
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
		javascript = {
			default_task = "run",
			tasks = {
				run = {
					command = "NODE_ENV=localhost yarn start",
					output = TOGGLE_RUN,
				},
				sync = {
					command = "yarn run sync",
					output = TOGGLE_RUN,
				},
			},
		},

		dart = {
			default_task = "run",
			tasks = {
				run = {
					command = "FlutterRun",
					type = "vim",
				},
				sync = {
					command = "FlutterEmulators",
					type = "vim",
				},
				test = {
					command = "FlutterDevices",
					type = "vim",
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

require("telescope").load_extension("yabs")

vim.api.nvim_set_keymap("n", "<F1>", [[:lua require("yabs"):run_default_task()<CR>]], {
	noremap = true,
	silent = true,
})
vim.api.nvim_set_keymap("t", "<F1>", [[<cmd>lua TOGGLE_RUN()<CR>]], {
	noremap = true,
	silent = true,
})
vim.api.nvim_set_keymap("n", "<F2>", [[:Telescope yabs tasks<CR>]], { noremap = true, silent = true })
