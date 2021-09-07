local saga = require 'lspsaga'
local mapper = require("nvim-mapper")

saga.init_lsp_saga {
    -- add your config value here
    -- default value
    -- use_saga_diagnostic_sign = true
    -- error_sign = '',
    -- warn_sign = '',
    -- hint_sign = '',
    -- infor_sign = '',
    -- dianostic_header_icon = '   ',
    -- code_action_icon = ' ',
    -- code_action_prompt = {
    --   enable = true,
    --   sign = true,
    --   sign_priority = 20,
    --   virtual_text = true,
    -- },
    -- finder_definition_icon = '  ',
    -- finder_reference_icon = '  ',
    -- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
    -- finder_action_keys = {
    --   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
    -- },
    -- code_action_keys = {
    --   quit = 'q',exec = '<CR>'
    -- },
    -- rename_action_keys = {
    --   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
    -- },
    -- definition_preview_icon = '  '
    -- "single" "double" "round" "plus"
    -- border_style = "single"
    -- rename_prompt_prefix = '➤',
    -- if you don't use nvim-lspconfig you must pass your server name and
    -- the related filetypes into this table
    -- like server_filetype_map = {metals = {'sbt', 'scala'}}
    -- server_filetype_map = {}
}

mapper.map("n", "<Leader>cf", ":Lspsaga lsp_finder<CR>",
           {silent = true, noremap = true}, "LSP", "lspsaga_finder",
           "Find definitions and reference for the word under the cursor.")

mapper.map("n", "<Leader>ca", ":Lspsaga code_action<CR>",
           {silent = true, noremap = true}, "LSP", "lspsaga_code_action",
           "Code Action")

mapper.map("v", "<Leader>ca", ":Lspsaga range_code_action<CR>",
           {silent = true, noremap = true}, "LSP", "lspsaga_range_code_action",
           "Code Action")

mapper.map("n", "K", ":Lspsaga hover_doc<CR>", {silent = true, noremap = true},
           "LSP", "lspsaga_hover_doc", "Show Hover Docs")

mapper.map("n", "<Leader>cs", ":Lspsaga signature_help<CR>",
           {silent = true, noremap = true}, "LSP", "lspsaga_signature_help",
           "Show Signature Help")

mapper.map("n", "<Leader>cr", ":Lspsaga rename<CR>",
           {silent = true, noremap = true}, "LSP", "lspsaga_rename",
           "Rename the word under cursor")

mapper.map("n", "<Leader>cd", ":Lspsaga preview_definition<CR>",
           {silent = true, noremap = true}, "LSP", "lspsaga_preview_definition",
           "Preview definition of the word under cursor")

mapper.map("n", "<Leader>cD", ":Lspsaga show_line_diagnostics<CR>",
           {silent = true, noremap = true}, "LSP",
           "lspsaga_show_line_diagnostics", "Show Line Diagnostics")

mapper.map("n", "<Leader>c{", ":Lspsaga diagnostic_jump_prev<CR>",
           {silent = true, noremap = true}, "LSP",
           "lspsaga_diagnostic_jump_prev", "Jump to previous Diagnostic")

mapper.map("n", "<Leader>c}", ":Lspsaga diagnostic_jump_next<CR>",
           {silent = true, noremap = true}, "LSP",
           "lspsaga_diagnostic_jump_next", "Jump to next Diagnostic")

mapper.map("n", "<C-u>",
           [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]],
           {silent = true, noremap = true}, "LSP",
           "lspsaga_scroll_with_saga_down", "Scroll Down in LSP Saga preview")

mapper.map("n", "<C-u>",
           [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]],
           {silent = true, noremap = true}, "LSP",
           "lspsaga_scroll_with_saga_up", "Scroll Up in LSP Saga preview")
