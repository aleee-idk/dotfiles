local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local titlebar_buttons = require("config.keys").titlebar_buttons

local titlebars = {}

function titlebars.top(client)

    local titlebar = awful.titlebar(client, {
        position = "top",
        size = beautiful.titlebar_size,
    })

    titlebar : setup {
        -- Left
        {
            buttons = titlebar_buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        -- Middle
        {
            -- Title
            {
                align  = beautiful.titlebar_title_align,
                widget = awful.titlebar.widget.titlewidget(client)
            },
            buttons = titlebar_buttons,
            layout  = wibox.layout.flex.horizontal
        },
        -- Right
        {
            layout = wibox.layout.fixed.horizontal(),
            buttons = titlebar_buttons,
        },
        layout = wibox.layout.align.horizontal
    }
end

return titlebars
