vim.cmd([[
	augroup templates
	autocmd BufNewFile *.sh 0r ~/dotfiles/config/nvim/templates/bash.temp
	augroup END
	]])
