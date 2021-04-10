local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local helpers = require("helpers")
local keys = require("keys")


-- ##### Widgets ##### -- {{{
    
font = beautiful.font

-- ===== Colors ===== -- {{{

local tag_colors_empty = { "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000" }

local tag_colors_urgent = { x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground }

local tag_colors_focused = {
    x.color1,
    x.color5,
    x.color4,
    x.color6,
    x.color2,
    x.color3,
    x.color1,
    x.color5,
    x.color4,
    x.color6,
}

local tag_colors_occupied = {
    x.color1.."45",
    x.color5.."45",
    x.color4.."45",
    x.color6.."45",
    x.color2.."45",
    x.color3.."45",
    x.color1.."45",
    x.color5.."45",
    x.color4.."45",
    x.color6.."45",
}

-- Helper function that updates a taglist item
local update_taglist = function (item, tag, index)
    if tag.selected then
        item.bg = beautiful.wibar_bg_focused
        item.fg = beautiful.wibar_fg_focused
    elseif tag.urgent then
        item.bg = beautiful.wibar_bg_urgent
        item.fg = beautiful.wibar_fg_urgent
    elseif #tag:clients() > 0 then
        item.bg = beautiful.wibar_bg_occupied
        item.fg = beautiful.wibar_fg_occupied
    else
        item.bg = beautiful.wibar_bg
        item.fg = beautiful.wibar_fg
    end
end

-- ===== Colors ===== -- }}}

-- ===== Bar Widgets ===== -- {{{

awful.screen.connect_for_each_screen(
    function(s)

        -- ***** Taglist ***** -- {{{

        s.mytaglist = awful.widget.taglist {
            screen = s,

            -- wich tags to include, all, selected or noempty
            filter = awful.widget.taglist.filter.all,
            buttons = keys.taglist_buttons,
            style = {
                    bg_focus = beautiful.wibar_bg_focused ,
                    fg_focus = beautiful.wibar_fg_focused ,
                    bg_urgent = beautiful.wibar_bg_urgent  ,
                    fg_urgent = beautiful.wibar_fg_urgent  ,
                    fg_occupied = beautiful.fg_occupied,
                    bg_occupied = beautiful.bg_occupied,
            },
            -- Look --
            -- layout = {
                -- spacing = 10,
                -- spacing_widget = {
                --     color  = '#00ff00',
                --     shape  = gears.shape.circle,
                --     widget = wibox.widget.separator,
                -- },
            --     layout = wibox.layout.flex.horizontal,
            -- },

            -- Functionallity --
            -- widget_template = {
            --     widget = wibox.container.background,
            --     create_callback = function(self, tag, index, _)
            --         update_taglist(self, tag, index)
            --     end,
            --     update_callback = function(self, tag, index, _)
            --         update_taglist(self, tag, index)
            --     end,
            -- }
        }


        -- ***** Taglist ***** -- }}}

        -- ***** Tasklist ***** -- {{{    

        -- s.taglist_box = awful.wibar({
        --     screen = s,
        --     visible = true,
        --     ontop = false,
        --     type = "dock",
        --     position = "top",
        --     height = dpi(10),
        --     -- position = "left",
        --     -- width = dpi(6),
        --     bg = "#00000000",
        -- })

        -- s.taglist_box:setup {
        --     widget = s.mytaglist,
        -- }

        -- ***** Tasklist ***** -- }}}

        -- ***** Systray ***** -- {{{

        -- Create a system tray widget
        s.systray = wibox.widget.systray()

        -- Create the tray popup

        s.syspopup = awful.popup {
            widget = {
                {
                    s.systray,
                    widget = wibox.container.background
                },
                layout = wibox.layout.fixed.vertical
            },
            preferred_positions = "bottom",
            preferred_anchors = "middle",
            type = "popup_menu",
            hide_on_right_click = true,
            minimum_width = dpi(100),
            minimum_height = dpi(100),
            shape = gears.shape.infobubble,
            ontop = true,
            visible = false
        }

        s.sysicon = wibox.widget {
            text = " ",
            font = font .. " 15",
            widget = wibox.widget.textbox
        }

        s.syspopup:bind_to_widget(s.sysicon)

        helpers.add_hover_cursor(s.sysicon, "hand1")

        -- ***** Systray ***** -- }}}

        -- ***** Layouts ***** --- {{{

        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(gears.table.join(
                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))

        -- ***** Layouts ***** --- }}}

        -- ***** Main Bar ***** --- {{{
        s.main_bar = awful.wibar({
            screen = s,
            visible = true,
            ontop = false,
            position = beautiful.wibar_position,
            -- height = 20,
            bg = beautiful.wibar_bg,
            fg = beautiful.wibar_fg,
        })

        s.main_bar:setup {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.align.horizontal,
                s.mytaglist,
            },
            {
                layout = wibox.layout.align.horizontal,
            },
            {
                s.mylayoutbox,
                s.sysicon,
                spacing = dpi(5),
                layout = wibox.layout.fixed.horizontal,
            },
        }

        -- ***** Main Bar ***** --- }}}
    end
)

-- ===== Bar Widgets ===== -- }}}

-- ##### Widgets ##### -- }}}