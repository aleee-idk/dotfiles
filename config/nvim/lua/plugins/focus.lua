local focus = require('focus')
local mapper = require('nvim-mapper')

-- Completely disable this plugin
-- Default: true
focus.enable = true

-- Force width for the focused window
-- Default: Calculated based on golden ratio
-- focus.width = 120

-- Force height for the focused window
-- Default: Calculated based on golden ratio
-- focus.height = 40

-- Sets the width of directory tree buffers such as NerdTree, NvimTree and CHADTree
-- Default: vim.g.nvim_tree_width or 30
-- focus.treewidth = 20

-- Displays a cursorline in the focussed window only
-- Not displayed in unfocussed windows
-- Default: true
-- focus.cursorline = false

-- Displays a sign column in the focussed window only
-- Not displayed in unfocussed windows
-- Default: true
-- focus.signcolumn = false

-- Displays line numbers in the focussed window only
-- Not displayed in unfocussed windows
-- Default: true
focus.number = true

-- Displays relative line numbers in the focussed window only
-- Not displayed in unfocussed windows
-- See :h relativenumber
-- Default: false
focus.relativenumber = true

-- Displays hybrid line numbers in the focussed window only
-- Not displayed in unfocussed windows
-- Combination of :h relativenumber, but also displays the line number of the current line only
-- Default: false
-- focus.hybridnumber = true

-- Enable auto highlighting for focussed/unfocussed windows
-- Default: false
focus.winhighlight = true

----------------------------------------------------------------------
--                             Mappings                             --
----------------------------------------------------------------------

mapper.map('n', '<C-h>', ':FocusSplitLeft<CR>', {silent = true}, "Windows",
           "focus_split_left", "Focus or Create Split to the Left")
mapper.map('n', '<C-j>', ':FocusSplitDown<CR>', {silent = true}, "Windows",
           "focus_split_down", "Focus or Create Split to the Down")
mapper.map('n', '<C-k>', ':FocusSplitUp<CR>', {silent = true}, "Windows",
           "focus_split_up", "Focus or Create Split to the Up")
mapper.map('n', '<C-l>', ':FocusSplitRight<CR>', {silent = true}, "Windows",
           "focus_split_right", "Focus or Create Split to the Right")
mapper.map('n', '<C-s>', ':FocusSplitNicely<CR>', {silent = true}, "Windows",
           "focus_split_nicely", "Balance Current Windows")
