require("focus")

require("focus").setup({

    -- Completely disable this plugin
    -- Default: true
    enable = true,

    -- Force width for the d window
    -- Default: Calculated based on golden ratio
    -- width = 120

    -- Force height for the d window
    -- Default: Calculated based on golden ratio
    -- height = 40

    -- Sets the width of directory tree buffers such as NerdTree, NvimTree and CHADTree
    -- Default: vim.g.nvim_tree_width or 30
    -- treewidth = 20

    -- Displays a cursorline in the ed window only
    -- Not displayed in uned windows
    -- Default: true
    -- cursorline = false

    -- Displays a sign column in the ed window only
    -- Not displayed in uned windows
    -- Default: true
    -- signcolumn = false

    -- Displays line numbers in the ed window only
    -- Not displayed in uned windows
    -- Default: true
    number = true,

    -- Displays relative line numbers in the ed window only
    -- Not displayed in uned windows
    -- See :h relativenumber
    -- Default: false
    relativenumber = true,

    -- Displays hybrid line numbers in the ed window only
    -- Not displayed in uned windows
    -- Combination of :h relativenumber, but also displays the line number of the current line only
    -- Default: false
    -- hybridnumber = true

    -- Enable auto highlighting for ed/unfocussed windows
    -- Default: false
    winhighlight = true
})

----------------------------------------------------------------------
--                             Mappings                             --
----------------------------------------------------------------------

vim.api.nvim_set_keymap('n', "<C-h>",
                        [[:lua require'focus'.split_command('h')<CR>]],
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', "<C-j>",
                        [[:lua require'focus'.split_command('j')<CR>]],
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', "<C-k>",
                        [[:lua require'focus'.split_command('k')<CR>]],
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', "<C-l>",
                        [[:lua require'focus'.split_command('l')<CR>]],
                        {noremap = true, silent = true})
