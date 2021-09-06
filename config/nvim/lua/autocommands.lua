-- AutoComands still in dev, come back later
-- only show cursorline on focused window
-- Fix md filetype
vim.cmd([[
	au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
	]])

-- Auto Center line on enter insert mode
vim.cmd([[
	autocmd InsertEnter * norm zz
	]])

-- Auto update plugins on plugins.lua save
vim.cmd([[
	autocmd BufWritePost pluginList.lua source % | PackerSync
	]])

-- only show cursorline on focused window

-- Fix md filetype
vim.cmd([[
	au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
	]])

-- Auto Center line on enter insert mode
vim.cmd([[
	autocmd InsertEnter * norm zz
	]])

-- Auto update plugins on plugins.lua save
vim.cmd([[
	autocmd BufWritePost plugins.lua source % | PackerSync
	]])

-- highlight yank selection
vim.cmd([[
 augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])
