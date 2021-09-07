local mapper = require('nvim-mapper')
-- Rest plugin need this before treesitter
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.http = {
    install_info = {
        url = "https://github.com/NTBBloodbath/tree-sitter-http",
        files = {"src/parser.c"},
        branch = "main"
    }
}

-- Note: Available capture groups and highlight group identifiers will be found in https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/highlight.lua file in the source code.
require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "http", "bash", "c", "cmake", "comment", "cpp", "css", "dockerfile",
        "elm", "fish", "gdscript", "html", "javascript", "jsdoc", "json",
        "latex", "lua", "nix", "python", "query", "regex", "typescript", "yaml"
    },

    highlight = {enable = true},

    incremental_selection = {enable = true},
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            -- The keymaps are defined in the configuration table, no way to get our Mapper in there !
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        }
    },

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

mapper.map_virtual("n", "gnn", "", {silent = true}, "Treesitter",
                   "treesitter_init_selection",
                   "Initialize Incremental Selection")
mapper.map_virtual("n", "grn", "", {silent = true}, "Treesitter",
                   "treesitter_node_incremental", "Increment Node Selection")
mapper.map_virtual("n", "grm", "", {silent = true}, "Treesitter",
                   "treesitter_node_decremental", "Decrement Node Selection")
mapper.map_virtual("n", "grc", "", {silent = true}, "Treesitter",
                   "treesitter_scope_incremental", "Increment Scope Selection")

mapper.map_virtual("o", "af", "", {}, "Treesitter", "treesitter_function_outer",
                   "Function outer motion")
mapper.map_virtual("o", "if", "", {}, "Treesitter", "treesitter_function_inner",
                   "Function inner motion")
mapper.map_virtual("o", "ac", "", {}, "Treesitter", "treesitter_class_outer",
                   "Class outer motion")
mapper.map_virtual("o", "ic", "", {}, "Treesitter", "treesitter_class_inner",
                   "Class inner motion")
