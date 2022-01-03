require("nvim-comment-frame").setup({

	-- if true, <leader>cf keymap will be disabled
	disable_default_keymap = true,

	-- width of the comment frame
	frame_width = 70,

	-- wrap the line after 'n' characters
	line_wrap_len = 50,

	-- automatically indent the comment frame based on the line
	auto_indent = true,

	-- add comment above the current line
	add_comment_above = true,

	-- configurations for individual language goes here
	languages = {
		dosini = {
			start_str = ";;",
			end_str = ";;",
			fill_char = "*",
			auto_indent = false,
		},
		conf = {
			start_str = "#",
			end_str = "#",
			fill_char = "*",
			auto_indent = false,
		},
	},
})

vim.api.nvim_set_keymap(
	"n",
	"<Leader>ih",
	":lua require('nvim-comment-frame').add_comment()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>iH",
	":lua require('nvim-comment-frame').add_multiline_comment()<CR>",
	{ noremap = true, silent = true }
)
