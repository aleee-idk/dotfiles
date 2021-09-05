-- Default FZF
vim.g.dashboard_default_executive = "telescope"

-- Custom Shortcuts
-- TODO: Change this for telescope equivalents
vim.api.nvim_set_keymap('n', '<Leader>db', ":DashboardJumpMark<CR>",
                        {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>dh', ":DashboardFindHistory<CR>",
                        {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>df', ":DashboardFindFile<CR>",
                        {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>dn', ":DashboardNewFile<CR>",
                        {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>da', ":DashboardFindWord<CR>",
                        {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>dc', ":DashboardChangeColorscheme<CR>",
                        {silent = true})

-- Show mappings
vim.g.dashboard_custom_shortcut = {
    last_session = 'SPC s l',
    book_marks = 'SPC d b',
    find_history = 'SPC d h',
    find_file = 'SPC d f',
    new_file = 'SPC d n',
    find_word = 'SPC d a',
    change_colorscheme = 'SPC d c'
}

-- Hide tabline on dashboard
vim.cmd([[
	autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
	]])
