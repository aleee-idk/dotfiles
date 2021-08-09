local mapper = require("nvim-mapper")
-- don't close terminals on hidden
vim.opt.hidden = true

require("toggleterm").setup {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = false,
    -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = 'float', -- 'vertical' | 'horizontal' | 'window' | 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'single', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        width = math.ceil(vim.o.columns * 0.8),
        height = math.ceil(vim.o.lines * 0.6),
        winblend = 0,
        highlights = {border = "Normal", background = "Normal"}
    }
}

-- Toggle Terminals
mapper.map('n', '<Leader>mf', [[:1ToggleTerm<CR>]],
           {silent = true, noremap = true}, "Terminal", "toggle_term_1",
           "Toggle terminal 1")
mapper.map('n', '<Leader>md', [[:2ToggleTerm<CR>]],
           {silent = true, noremap = true}, "Terminal", "toggle_term_2",
           "Toggle terminal 2")
mapper.map('n', '<Leader>ms', [[:3ToggleTerm<CR>]],
           {silent = true, noremap = true}, "Terminal", "toggle_term_3",
           "Toggle terminal 3")
