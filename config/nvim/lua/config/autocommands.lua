-- AutoComands still in dev, come back later

-- Fix md filetype
vim.cmd(
	[[
	au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
	]]
)

-- Auto Center line on enter insert mode
vim.cmd(
	[[
	autocmd InsertEnter * norm zz
	]]
)

-- Auto update plugins on plugins.lua save
vim.cmd(
	[[
	autocmd BufWritePost plugins.lua source % | PackerSync
	]]
)

