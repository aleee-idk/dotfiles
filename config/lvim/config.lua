-- general
vim.opt.shell = "/usr/bin/env bash"
lvim.format_on_save = true
lvim.lint_on_save = true
vim.opt.scrolloff = 15
vim.cmd([[
set fo+=cro
set noswapfile
]])

lvim.autocommands.custom_groups = {
	-- On entering insert mode in any file, scroll the window so the cursor line is centered
	{ "InsertEnter", "*", ":normal zz" },
}

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.term_mode["<F12>"] = [[<C-\><C-n>]]

-- Delete without override yanked text
vim.api.nvim_set_keymap("n", "d", [["_d]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "d", [["_d]], { noremap = true, silent = true })

-- Map D -> default vim "d"
vim.api.nvim_set_keymap("n", "D", "d", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "D", "d", { noremap = true, silent = true })

-- plugins
require("user.listPlugins")
require("user.plugins.builtin")

----------------------------------------------------------------------
--                               LSP                                --
----------------------------------------------------------------------

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "black" },
	{ exe = "fish_indent" },
	{ exe = "gofumpt" },
	{ exe = "prettier" },
	{ exe = "reorder-python-imports" },
	{ exe = "rustfmt" },
	{ exe = "shfmt" },
	{ exe = "stylua" },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ exe = "eslint_d" },
	{ exe = "flake8" },
	{ exe = "luacheck", args = { "--globals", "lvim" } },
	{ exe = "shellcheck" },
})

lvim.lsp.on_attach_callback = function(client, _)
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
	require("lsp_signature").on_attach()
end

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- IDK why this doesn't work outside config.lua
lvim.builtin.which_key.mappings["t"] = {
	name = "Diagnostics",
	t = { "<cmd>TroubleToggle<cr>", "trouble" },
	w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
	q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
	l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
	r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- ColorScheme
require("user.aesthetics")
