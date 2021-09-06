local mapper = require("nvim-mapper")
local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) mapper.map_buf(bufnr, ...) end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts,
                   "LSP", "lsp_declarations", "Go to delaration")
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts,
                   "LSP", "lsp_definition", "Go to definition")
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts, "LSP",
                   "lsp_hover", "Show tooltip")
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts,
                   "LSP", "lsp_implementation", "Go to implementation")
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
    -- opts, "LSP", "lsp_signature", "Show Signature")
    --[[ buf_set_keymap('n', '<Leader>wa',
                   '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts,
                   "LSP", "lsp_workspace_add", "Add Workspace")
    buf_set_keymap('n', '<Leader>wr',
                   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts,
                   "LSP", "lsp_workspace_remove", "Remove Workspace")
    buf_set_keymap('n', '<Leader>cw',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                   opts, "LSP", "lsp_inspect", "Inspect Workspace") ]]
    buf_set_keymap('n', '<Leader>cd',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts, "LSP",
                   "lsp_type_definition", "Type Definition")
    buf_set_keymap('n', '<Leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts,
                   "LSP", "lsp_buf_rename", "Rename Buffer")
    -- buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<Leader>e',
                   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
                   opts, "LSP", "lsp_show_diagnostics", "Show Diagnostics")
    buf_set_keymap('n', 'g{', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
                   opts, "LSP", "lsp_diagnostics_goto_prev",
                   "Go To Previous Diagnostic")
    buf_set_keymap('n', 'g}', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
                   opts, "LSP", "lsp_diagnostics_goto_next",
                   "Go To Next Diagnostic")
    -- buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap("n", "<Leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>",
                   opts, "LSP", "lsp_format", "Format Buffer")

    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

    -- TODO: Config https://github.com/ray-x/lsp_signature.nvim
    require('lsp_signature').on_attach()

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local function setup_servers()
    require'lspinstall'.setup()
    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do
        nvim_lsp[server].setup {
            on_attach = on_attach,
            settings = {Lua = {diagnostics = {globals = {'vim'}}}}
        }
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- Code Actions
--[[ require'nvim-lightbulb'.update_lightbulb {
    sign = {
        enabled = true,
        -- Priority of the gutter sign
        priority = 10,
    },
    float = {
        enabled = false,
        -- Text to show in the popup float
        text = "💡",
    },
    virtual_text = {
        enabled = false,
        -- Text to show at virtual text
        text = "💡",
    },
    status_text = {
        enabled = false,
        -- Text to provide when code actions are available
        text = "💡",
        -- Text to provide when no actions are available
        text_unavailable = ""
    }
} ]]
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
