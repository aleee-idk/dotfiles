local mapper = require("nvim-mapper")

require("harpoon").setup({
    global_settings = {save_on_toggle = false, save_on_change = true}
})

-- Mark list
mapper.map('n', '<Leader>mq',
           [[:lua require("harpoon.ui").toggle_quick_menu()<CR>]],
           {silent = true, noremap = true}, "harpoon", "quick_menu",
           "Open list of marked files")

-- Mark File
mapper.map('n', '<Leader>ma', [[:lua require("harpoon.mark").add_file()<CR>]],
           {silent = true, noremap = true}, "harpoon", "add_file",
           "Add current file to mark list")

-- Open marked file
mapper.map('n', '<Leader>mj', [[:lua require("harpoon.ui").nav_file(1)<CR>]],
           {silent = true, noremap = true}, "harpoon", "file_navigation_1",
           "Go to marked file 1")
mapper.map('n', '<Leader>mk', [[:lua require("harpoon.ui").nav_file(2)<CR>]],
           {silent = true, noremap = true}, "harpoon", "file_navigation_2",
           "Go to marked file 2")
mapper.map('n', '<Leader>ml', [[:lua require("harpoon.ui").nav_file(3)<CR>]],
           {silent = true, noremap = true}, "harpoon", "file_navigation_3",
           "Go to marked file 3")
