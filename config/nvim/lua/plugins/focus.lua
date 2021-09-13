require('focus')
local mapper = require('nvim-mapper')

require('focus').setup({

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

mapper.map('n', '<C-h>', [[:lua require'focus'.split_command('h')<CR>]],
           {silent = true}, "Windows", "focus_split_left",
           "Focus or Create Split to the Left")
mapper.map('n', '<C-j>', [[:lua require'focus'.split_command('j')<CR>]],
           {silent = true}, "Windows", "focus_split_down",
           "Focus or Create Split to the Down")
mapper.map('n', '<C-k>', [[:lua require'focus'.split_command('k')<CR>]],
           {silent = true}, "Windows", "focus_split_up",
           "Focus or Create Split to the Up")
mapper.map('n', '<C-l>', [[:lua require'focus'.split_command('l')<CR>]],
           {silent = true}, "Windows", "focus_split_right",
           "Focus or Create Split to the Right")
