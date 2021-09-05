-- Treesitter
-- Note: Available capture groups and highlight group identifiers will be found in https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/highlight.lua file in the source code.
require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "bash", "c", "cmake", "comment", "cpp", "css", "dockerfile", "elm",
        "fish", "gdscript", "html", "javascript", "jsdoc", "json", "latex",
        "lua", "nix", "python", "query", "regex", "typescript", "yaml"
    },

    highlight = {enable = true},

    incremental_selection = {enable = true},

    indent = {enable = true},

    rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 1000 -- Do not enable for files with more than 1000 lines, int
    }
})

vim.api.nvim_exec([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
	]], true)
