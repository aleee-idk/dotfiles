-- general
vim.opt.shell = "/usr/bin/env bash"
lvim.format_on_save = true
lvim.lint_on_save = true
vim.opt.scrolloff = 15

lvim.autocommands.custom_groups = {
	-- On entering insert mode in any file, scroll the window so the cursor line is centered
	{ "InsertEnter", "*", ":normal zz" },
}

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.term_mode["<F12>"] = [[<C-\><C-n>]]
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- plugins
require("user.listPlugins")
require("user.plugins.builtin")

----------------------------------------------------------------------
--                               LSP                                --
----------------------------------------------------------------------

-- set a formatter if you want to override the default lsp one (if it exists)
lvim.lang.python.formatters = { { exe = "black" } }
lvim.lang.python.linters = { { exe = "flake8" } }

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "prettier",
		filetypes = {
			"javascriptreact",
			"javascript",
			"typescriptreact",
			"typescript",
			"json",
			"markdown",
		},
	},
})

lvim.lsp.on_attach_callback = function(client, _)
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
end

-- lvim.lang.javascript.formatters = { { exe = "prettier" } }
-- lvim.lang.javascript.linters = { { exe = "eslint_d" } }
-- lvim.lang.javascriptreact.formatters = lvim.lang.javascript.formatters
-- lvim.lang.javascriptreact.linters = lvim.lang.javascript.lintes

-- lvim.lang.typescript.formatters = { { exe = "prettier" } }
-- lvim.lang.typescript.linters = { { exe = "eslint_d" } }
-- lvim.lang.typescriptreact.formatters = lvim.lang.javascript.formatters
-- lvim.lang.typescriptreact.linters = lvim.lang.javascript.lintes

lvim.lang.json.formatters = { { exe = "prettier" } }

lvim.lang.lua.formatters = { { exe = "stylua" } }
lvim.lang.lua.linters = { { exe = "luacheck", args = { "--globals", "lvim" } } }

lvim.lang.markdown.formatters = { { exe = "prettier" } }

require("null-ls").config({
	debug = true,
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- ColorScheme
require("user.aesthetics")
