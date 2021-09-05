-- Telescope.nvim
local telescope = require("telescope")

-- Extensions
telescope.load_extension("media_files")
telescope.load_extension("projects")
telescope.load_extension("mapper")

-- Open Files
vim.api.nvim_set_keymap('n', "<Leader>ff", [[<cmd>Telescope find_files<CR>]],
                        {noremap = true})
vim.api.nvim_set_keymap('n', "<Leader>fF", [[<cmd>Telescope file_browser<CR>]],
                        {noremap = true})
vim.api.nvim_set_keymap('n', "<Leader>fp", [[<cmd>Telescope projects<CR>]],
                        {noremap = true})
vim.api.nvim_set_keymap('n', "<Leader>fi", [[<cmd>Telescope media_files<CR>]],
                        {noremap = true})

-- Find stuff
vim.api.nvim_set_keymap('n', "<Leader>fs", [[<cmd>Telescope live_grep<CR>]],
                        {noremap = true})

-- Spell suggestions
vim.api.nvim_set_keymap('n', "<Leader>fs", [[<cmd>Telescope spell_suggest<CR>]],
                        {noremap = true})

-- List vim stuff
vim.api.nvim_set_keymap('n', "<Leader>fb", [[<cmd>Telescope buffers<CR>]],
                        {noremap = true})
vim.api.nvim_set_keymap('n', "<Leader>fh", [[<cmd>Telescope help_tags<CR>]],
                        {noremap = true})
vim.api.nvim_set_keymap('n', "<Leader>fm", [[<cmd>Telescope man_pages<CR>]],
                        {noremap = true})
vim.api.nvim_set_keymap('n', "<Leader>fc", [[<cmd>Telescope colorscheme<CR>]],
                        {noremap = true})

-- List LSP Stuff
vim.api.nvim_set_keymap('n', "<Leader>fq", [[<cmd>Telescope quickfix<CR>]],
                        {noremap = true})
vim.api.nvim_set_keymap('n', "<Leader>gr", [[<cmd>Telescope lsp_reference<CR>]],
                        {noremap = true})
vim.api.nvim_set_keymap('n', "<Leader>ca",
                        [[<cmd>Telescope lsp_code_actions<CR>]],
                        {noremap = true})
vim.api.nvim_set_keymap('n', "<Leader>fd",
                        [[<cmd>Telescope lsp_document_diagnostics<CR>]],
                        {noremap = true})
vim.api.nvim_set_keymap('n', "<Leader>fD",
                        [[<cmd>Telescope lsp_workspace_diagnostics<CR>]],
                        {noremap = true})

-- TODO: Add git mappings?

-- Config
local telescope_actions = require("telescope.actions")
telescope.setup {
    defaults = {
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        entry_prefix = "  ",
        initial_mode = "insert",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {mirror = false},
            vertical = {mirror = false}
        },
        file_ignore_patterns = {"%.env", "cache", ".xlsx"},
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        mappings = {
            i = {
                -- To disable a keymap, put [map] = false
                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = telescope_actions.select_horizontal,
                -- Add up multiple telescope_actions
                -- ["<cr>"] = telescope_actions.select_default + actions.center,
                ["<C-j>"] = telescope_actions.move_selection_next,
                ["<C-k>"] = telescope_actions.move_selection_previous,
                ["<C-s>"] = telescope_actions.file_vsplit,
                ["<C-v>"] = telescope_actions.file_split,
                ["<ESC>"] = telescope_actions.close
            },
            n = {
                ["gg"] = telescope_actions.move_to_top,
                ["G"] = telescope_actions.move_to_bottom,
                ["s"] = telescope_actions.file_vsplit,
                ["v"] = telescope_actions.file_split
            }
        },
        prompt_prefix = "> ",
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        scroll_strategy = nil,
        selection_caret = "* ",
        selection_strategy = "reset",
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        path_display = {},
        sorting_strategy = "descending",
        use_less = true,
        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename',
            '--line-number', '--column', '--smart-case'
        },
        winblend = 0,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },
    -- Specific config
    pickers = {
        buffers = {
            sort_lastused = true,
            mappings = {
                i = {["d"] = require("telescope.actions").delete_buffer},
                n = {["<c-d>"] = require("telescope.actions").delete_buffer}
            }
        },
        find_files = {},

        live_grep = {
            -- Limit search to open files
            grep_open_files = true
        }
    },
    extensions = {
        extensions = {
            media_files = {
                -- filetypes whitelist
                -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                filetypes = {"png", "webp", "jpg", "jpeg"},
                find_cmd = "rg" -- find command (defaults to `fd`)
            }
        }
    }
}
