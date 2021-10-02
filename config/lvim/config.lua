-- general
vim.opt.shell = "/usr/bin/env bash"
lvim.format_on_save = true
lvim.lint_on_save = true

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

-- set a formatter if you want to override the default lsp one (if it exists)
lvim.lang.python.formatters = { { exe = "black" } }
lvim.lang.python.linters = { { exe = "flake8" } }

lvim.lang.javascript.formatters = { { exe = "prettier" } }
lvim.lang.javascript.linters = { { exe = "eslint" } }
lvim.lang.javascriptreact.formatters = lvim.lang.javascript.formatters
lvim.lang.javascriptreact.linters = lvim.lang.javascript.lintes

lvim.lang.typescript.formatters = { { exe = "prettier" } }
lvim.lang.typescript.linters = { { exe = "eslint" } }
lvim.lang.typescriptreact.formatters = lvim.lang.javascript.formatters
lvim.lang.typescriptreact.linters = lvim.lang.javascript.lintes

lvim.lang.json.formatters = { { exe = "prettier" } }

lvim.lang.lua.formatters = { { exe = "stylua" } }
lvim.lang.lua.linters = { { exe = "luacheck", args = { "--globals", "lvim" } } }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- ColorScheme
require("user.aesthetics")
