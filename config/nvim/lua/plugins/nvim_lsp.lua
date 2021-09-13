local mapper = require("nvim-mapper")
local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

    -- TODO: Config https://github.com/ray-x/lsp_signature.nvim
    require('lsp_signature').on_attach()

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local function setup_servers()
    require'lspinstall'.setup()
    local servers = require'lspinstall'.installed_servers()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    for _, server in pairs(servers) do
        nvim_lsp[server].setup {
            on_attach = on_attach,
            settings = {Lua = {diagnostics = {globals = {'vim'}}}},
            capabilities = capabilities
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
        priority = 10
    },
    float = {
        enabled = false,
        -- Text to show in the popup float
        text = "💡"
    },
    virtual_text = {
        enabled = false,
        -- Text to show at virtual text
        text = "💡"
    },
    status_text = {
        enabled = false,
        -- Text to provide when code actions are available
        text = "💡",
        -- Text to provide when no actions are available
        text_unavailable = ""
    }
}
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
-- ]]
