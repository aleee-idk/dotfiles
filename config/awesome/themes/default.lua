local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")

local theme_name = "default"

local themes_path = gfs.get_themes_dir()
local xrdb = xresources.get_current_theme()


local theme = {}

-- ##### Colors font and Wallpaper ##### ---

theme.font = "CaskaydiaCove Nerd Font"

-- Set theme wallpaper.
-- It won't change anything if you are using feh to set the wallpaper like I do.
theme.wallpaper = os.getenv("HOME") .. "/.config/awesome/themes/wallpaper.jpg"


-- This is how to get other .Xresources values (beyond colors 0-15, or custom variables)
-- local cool_color = awesome.xrdb_get_value("", "color16")

--                 xrdb variable
theme.color0     = xrdb.color0
theme.color1     = xrdb.color1
theme.color2     = xrdb.color2
theme.color3     = xrdb.color3
theme.color4     = xrdb.color4
theme.color5     = xrdb.color5
theme.color6     = xrdb.color6
theme.color7     = xrdb.color7
theme.color8     = xrdb.color8
theme.color9     = xrdb.color9
theme.color10    = xrdb.color10
theme.color11    = xrdb.color11
theme.color12    = xrdb.color12
theme.color13    = xrdb.color13
theme.color14    = xrdb.color14
theme.color15    = xrdb.color15

-- Color with little transparency
theme.bg_transparent = "#00000022"

theme.bg_dark       = xrdb.background
theme.bg_normal     = xrdb.color0
theme.bg_occupied   = xrdb.color2
theme.bg_focus      = xrdb.color8
theme.bg_urgent     = xrdb.color8
theme.bg_minimize   = xrdb.color8
theme.bg_systray    = xrdb.color8
theme.systray_icon_spacing = dpi(5)

theme.fg_normal     = xrdb.foreground
theme.fg_occupied   = xrdb.color1
theme.fg_focus      = xrdb.color4
theme.fg_urgent     = xrdb.color9
theme.fg_minimize   = xrdb.color8
theme.fg_systray    = xrdb.foreground


-- ##### Client stuff ##### ---

-- Gaps
theme.useless_gap   = dpi(5)
-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(5)

-- Borders
theme.border_width  = dpi(3)
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus

-- Rounded corners
theme.border_radius = dpi(10)

-- Titlebars
theme.titlebars_enabled = true
theme.titlebar_size = dpi(20)
theme.titlebar_font = theme.font

-- Window title alignment: left, right, center
theme.titlebar_title_align = "center"

theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_focus
theme.titlebar_fg_normal = theme.fg_normal

-- ##### Notifications ##### ---

-- Position: bottom_left, bottom_right, bottom_middle, top_left, top_right, top_middle
theme.notification_position = "top_right"
theme.notification_font = theme.font

-- Size
theme.notification_max_width = dpi(600)
theme.notification_max_height = dpi(600)
theme.notification_margin = dpi(16)
theme.notification_icon_size = dpi(40)

-- Colors
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_opacity = 1

-- Borders
theme.notification_border_width = dpi(2)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = theme.notification_fg

-- Edge snap
-- TODO: Figure out where this is used

theme.snap_shape = gears.shape.rectangle
theme.snap_bg = xrdb.foreground
theme.snap_border_width = dpi(3)

-- ##### Bar ##### ---

-- Tag
theme.tagnames = {
    " ", -- 1 --
    " ", -- 2 --
    " ", -- 3 --
    "ﯢ ", -- 4 --
    " ", -- 5 --
    " ", -- 6 --
    " ", -- 7 --
    " ", -- 8 --
    " ", -- 9 --
    " ", -- 10 --
}
theme.taglist_font = theme.font
-- theme.taglist_shape =

-- Colors
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_bg_urgent = theme.bg_urgent
theme.taglist_fg_urgent = theme.fg_urgent
theme.taglist_bg_occupied = theme.bg_occupied
theme.taglist_fg_occupied = theme.fg_occupied
-- theme.taglist_bg_empty =
-- theme.taglist_fg_empty =
-- theme.taglist_bg_volatile =
-- theme.taglist_fg_volatile =

-- Size
theme.taglist_spacing = dpi(3)

-- Widget separator
theme.separator_text = "|"
--theme.separator_text = " :: "
--theme.separator_text = " • "
-- theme.separator_text = " •• "
theme.separator_fg = xrdb.color8

-- Wibar(s)
-- Keep in mind that these settings could be ignored by the bar theme
theme.wibar_position = "top"
theme.wibar_height = dpi(25)

-- Wibar colors
theme.wibar_fg = theme.fg_normal
theme.wibar_bg = theme.bg_transparent

theme.wibar_fg_focused = theme.fg_focus
theme.wibar_bg_focused = theme.bg_focus

theme.wibar_fg_urgent = theme.fg_urgent
theme.wibar_bg_urgent = theme.bg_urgent

theme.wibar_fg_occupied = theme.fg_normal
theme.wibar_bg_occupied = theme.bg_normal

--theme.wibar_opacity = 0.7
theme.wibar_border_color = xrdb.color0
theme.wibar_border_width = dpi(0)
theme.wibar_border_radius = dpi(0)
theme.wibar_width = dpi(380)

theme.prefix_fg = xrdb.color8

--There are other variable sets
--overriding the default one when
--defined, the sets are:
--taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
--tasklist_[bg|fg]_[focus|urgent]
--titlebar_[bg|fg]_[normal|focus]
--tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
--mouse_finder_[color|timeout|animate_timeout|radius|factor]
--prompt_[fg|bg|fg_cursor|bg_cursor|font]
--hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
--Example:
--theme.taglist_bg_focus = "#ff0000"

-- ##### titlebar ##### ---
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
    awful.button({ }, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end)
    )

    awful.titlebar(c) : setup {
        { -- Left
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
    { -- Title
    align  = "center",
    widget = awful.titlebar.widget.titlewidget(c)
},
buttons = buttons,
layout  = wibox.layout.flex.horizontal
        },
        { -- Right
        awful.titlebar.widget.floatingbutton (c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton   (c),
        awful.titlebar.widget.ontopbutton    (c),
        awful.titlebar.widget.closebutton    (c),
        layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
}
end)

return theme
-- vim:foldmethod=syntax
