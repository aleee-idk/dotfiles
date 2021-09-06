local mapper = require('nvim-mapper')

      require("rest-nvim").setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Highlight request on run
        highlight = {
            enabled = true,
            timeout = 150,
        },
        -- Jump to request line on run
        jump_to_request = false,
        })

mapper.map("n", "<leader>rr", "<Plug>RestNvim", {silent=true}, "Rest Client","rest_run", "Run the request under the cursor")
mapper.map("n", "<leader>rp", "<Plug>RestNvimPreview", {silent=true}, "Rest Client","rest_preview", "Preview the Requested CURL command")
mapper.map("n", "<leader>rl", "<Plug>RestNvimLast", {silent=true}, "Rest Client","rest_last", "Run the last Request")
