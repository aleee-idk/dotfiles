require("rest-nvim").setup({
	-- Open request results in a horizontal split
	result_split_horizontal = false,
	-- Skip SSL verification, useful for unknown certificates
	skip_ssl_verification = false,
	-- Highlight request on run
	highlight = { enabled = true, timeout = 150 },
	-- Jump to request line on run
	jump_to_request = false,
})

lvim.builtin.which_key.mappings["r"] = {
	name = "Rest",
	r = { "<cmd>lua require('rest-nvim').run()<CR>" },
	p = { "<cmd>lua require('rest-nvim').preview()<CR>" },
	l = { "<cmd>lua require('rest-nvim').last()<CR>" },
}
