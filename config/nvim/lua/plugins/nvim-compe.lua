local mapper = require("nvim-mapper")

require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        -- vsnip = { priority = 100 },
        ultisnips = {priority = 100},
        -- luasnip = { priority = 100 },
        nvim_lsp = {priority = 100},
        path = {priority = 100},
        nvim_lua = {priority = 100},
        buffer = {priority = 100},
        treesitter = {priority = 95},
        calc = {priority = 90},
        spell = {priority = 90},
        tags = {priority = 90},
        emoji = {priority = 10}
    }
}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        return t "<S-Tab>"
    end
end

mapper.map("i", "<Tab>", "v:lua.tab_complete()", {expr = true}, "Completion",
           "insert_next", "Select next completion")
mapper.map("s", "<Tab>", "v:lua.tab_complete()", {expr = true}, "Completion",
           "select_next", "Select next completion")
mapper.map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true},
           "Completion", "insert_prev", "Select previous completion")
mapper.map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true},
           "Completion", "select_prev", "Select previous completion")
mapper.map("i", "<CR>", "compe#confirm('<CR>')", {noremap = true, expr = true},
           "Completion", "insert_confirm", "Confirm selection")
mapper.map("i", "<C-Space>", "compe#complete()", {noremap = true, expr = true},
           "Completion", "show", "Show aviable completions")

vim.opt.completeopt = "menuone,noselect"
