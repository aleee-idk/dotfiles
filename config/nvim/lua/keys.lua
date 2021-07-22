--[[

Modes:

| String value |   Help page      |     Affected modes                            |  Vimscript equivalent |
| -------------|------------------|-----------------------------------------------|-----------------------|
| ''           |   mapmode-nvo    |     Normal, Visual, Select, Operator-pending  |  :map                 |
| 'n'          |   mapmode-n      |     Normal                                    |  :nmap                |
| 'v'          |   mapmode-v      |     Visual and Select                         |  :vmap                |
| 's'          |   mapmode-s      |     Select                                    |  :smap                |
| 'x'          |   mapmode-x      |     Visual                                    |  :xmap                |
| 'o'          |   mapmode-o      |     Operator-pending                          |  :omap                |
| '!'          |   mapmode-ic     |     Insert and Command-line                   |  :map!                |
| 'i'          |   mapmode-i      |     Insert                                    |  :imap                |
| 'l'          |   mapmode-l      |     Insert, Command-line, Lang-Arg            |  :lmap                |
| 'c'          |   mapmode-c      |     Command-line                              |  :cmap                |
| 't'          |   mapmode-t      |     Terminal                                  |  :tmap                |

--]]

-- Define Mapping with:
-- vim.api.nvim_set_keymap(mode, keys, action, options)
-- options are defined in :help :map-argument

-- Leader Key
vim.g.mapleader = ' '
-- vim.g.mapleader = '\<Space>'

-- Split Navigation
vim.api.nvim_set_keymap('', "<C-h>", "<C-w>h", {})
vim.api.nvim_set_keymap('', "<C-j>", "<C-w>j", {})
vim.api.nvim_set_keymap('', "<C-k>", "<C-w>k", {})
vim.api.nvim_set_keymap('', "<C-l>", "<C-w>l", {})

-- Remove Search Highlight
vim.api.nvim_set_keymap('n', "<CR>", ":noh<CR>", {silent = true})

-- Toggle Autocomment
vim.api.nvim_set_keymap('', "<Leader>tc", ":setlocal formatoptions=cro<CR>", {silent = true})
vim.api.nvim_set_keymap('', "<Leader>tC", ":setlocal formatoptions-=cro<CR>", {silent = true})

-- Toggle Auto Indent
vim.api.nvim_set_keymap('', "<Leader>ti", ":setlocal autoindent<CR>", {silent = true})
vim.api.nvim_set_keymap('', "<Leader>tI", ":setlocal noautoindent<CR>", {silent = true})

-- Toggle Spell Check
vim.api.nvim_set_keymap('', "<Leader>ts", ":setlocal spell<CR>", {silent = true})
vim.api.nvim_set_keymap('', "<Leader>tS", ":setlocal spell!<CR>", {silent = true})

-- Exit terminal mode
vim.api.nvim_set_keymap('t', '<ESC>', [[<C-\><C-n>]], {noremap = true})

-- Session managment
vim.api.nvim_set_keymap('n', '<Leader>ss', ":<C-u>SessionSave<CR>", {})
vim.api.nvim_set_keymap('n', '<Leader>sl', ":<C-u>SessionLoad<CR>", {})
