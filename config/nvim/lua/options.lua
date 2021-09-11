--[[
vim.opt.{option}         ->  :set
vim.opt_global.{option}  ->  :setglobal
vim.opt_local.{option}   ->  :setlocal
--]] -- Set Shell
vim.opt.shell = "/usr/bin/env bash"
vim.g.python3_host_prog = "/usr/bin/python3"

-- Use System clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable Mouse
vim.opt.mouse = "a"

-- Set Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Identation
local indent = 4
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent
vim.opt.softtabstop = indent

-- Keep cursor centered
vim.opt.scrolloff = 15

-- Ignore case when searching
vim.opt.ignorecase = true

-- Override the 'ignorecase' option if the search pattern contains case characters.
vim.opt.smartcase = true

-- Wrap Search
vim.opt.wrapscan = true

-- Autocompletion with 'wildchar'
vim.opt.wildmode = "longest,list,full"

-- Fix Sppliting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set undofile
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undo"
vim.opt.undolevels = 1000

-- Open already open windows
vim.opt.switchbuf = 'usetab'

-- Enable folding for markdown files
vim.g.markdown_folding = 2
