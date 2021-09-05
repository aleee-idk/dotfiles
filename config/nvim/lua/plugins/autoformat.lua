-- Auto Format
require('formatter').setup({
    logging = false,
    filetype = {
        javascript = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath", vim.api.nvim_buf_get_name(0),
                        '--single-quote'
                    },
                    stdin = true
                }
            end
        },
        json = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath", vim.api.nvim_buf_get_name(0),
                        '--single-quote'
                    },
                    stdin = true
                }
            end
        },
        lua = {
            -- luafmt
            function()
                return {
                    exe = "lua-format",
                    -- args = {"--indent-count", 2, "--stdin"},
                    stdin = true
                }
            end
        },
        python = {
            function()
                return {
                    exe = "black",
                    args = {"--stdin-filename", vim.api.nvim_buf_get_name(0)},
                    stdin = false
                }
            end
        }
    }
})

vim.cmd([[
    augroup FormatAutogroup
      autocmd!
      autocmd BufWritePost *.json,*.js,*.lua,*.py silent! FormatWrite
    augroup END
]])
