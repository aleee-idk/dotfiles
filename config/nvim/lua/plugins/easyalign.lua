local mapper = require("nvim-mapper")

-- Start interactive EasyAlign in visual mode (e.g. vipga)
mapper.map('x', "ga", [[<Plug>(EasyAlign)]], {}, "EasyAlign",
           "easyalign_start_visual",
           "Start interactive EasyAlign in visual mode")

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
mapper.map('n', "ga", [[<Plug>(EasyAlign)]], {}, "EasyAlign",
           "easyalign_start_motion", "Start interactive EasyAlign with a motion")
