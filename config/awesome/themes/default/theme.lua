local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")

local theme_name = "default"

local themes_path = gfs.get_themes_dir()
-- local layout_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/layout/"
-- local titlebar_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/titlebar/"
-- local taglist_icon_path = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme_name .. "/taglist/"
-- local tip = titlebar_icon_path --alias to save time/space
local xrdb = xresources.get_current_theme()


local theme = {}

-- ##### Colors font and Wallpaper ##### --- {{{

theme.font = "CaskaydiaCove Nerd Font"

-- Set theme wallpaper.
-- It won't change anything if you are using feh to set the wallpaper like I do.
theme.wallpaper = os.getenv("HOME") .. "/.config/awesome/themes/wallpaper.jpg"

-- Set the theme font. This is the font that will be used by default in menus, bars, titlebars etc.
-- theme.font          = "sans 11"
-- theme.font          = "monospace 11"

-- This is how to get other .Xresources values (beyond colors 0-15, or custom variables)
-- local cool_color = awesome.xrdb_get_value("", "color16")

theme.bg_dark       = x.background
theme.bg_normal     = x.color0
theme.bg_occupied   = x.color2
theme.bg_focus      = x.color8
theme.bg_urgent     = x.color8
theme.bg_minimize   = x.color8
theme.bg_systray    = x.background

theme.fg_normal     = x.foreground
theme.fg_occupied   = x.color1
theme.fg_focus      = x.color4
theme.fg_urgent     = x.color9
theme.fg_minimize   = x.color8

theme.bg_transparent = "#00000022"

-- ##### Client stuff ##### ---

-- Gaps
theme.useless_gap   = dpi(5)
-- This could be used to manually determine how far away from the
-- screen edge the bars / notifications should be.
theme.screen_margin = dpi(5)

-- Borders
theme.border_width  = dpi(0)
-- theme.border_color = x.color0
theme.border_normal = x.background
theme.border_focus  = x.background

-- Rounded corners
theme.border_radius = dpi(6)

-- Titlebars
-- (Titlebar items can be customized in titlebars.lua)
theme.titlebars_enabled = false
theme.titlebar_size = dpi(35)
theme.titlebar_title_enabled = false
theme.titlebar_font = "sans bold 9"
-- Window title alignment: left, right, center
theme.titlebar_title_align = "center"
-- Titlebar position: top, bottom, left, right
theme.titlebar_position = "top"
theme.titlebar_bg = x.background
-- theme.titlebar_bg_focus = x.color12
-- theme.titlebar_bg_normal = x.color8
theme.titlebar_fg_focus = x.background
theme.titlebar_fg_normal = x.color8
--theme.titlebar_fg = x.color7

-- ##### Notifications ##### ---

-- Note: Some of these options are ignored by my custom
-- notification widget_template
-- Position: bottom_left, bottom_right, bottom_middle,
--         top_left, top_right, top_middle

theme.notification_position = "top_right"
theme.notification_border_width = dpi(0)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = x.color10
theme.notification_bg = x.background
-- theme.notification_bg = x.color8
theme.notification_fg = x.foreground
theme.notification_crit_bg = x.background
theme.notification_crit_fg = x.color1
theme.notification_icon_size = dpi(60)
-- theme.notification_height = dpi(80)
-- theme.notification_width = dpi(300)
theme.notification_margin = dpi(16)
theme.notification_opacity = 1
-- theme.notification_font = "sans 11"
theme.notification_padding = theme.screen_margin * 2
theme.notification_spacing = theme.screen_margin * 4

-- Edge snap

theme.snap_shape = gears.shape.rectangle
theme.snap_bg = x.foreground
theme.snap_border_width = dpi(3)

-- Tag names
theme.tagnames = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
}

-- ##### Bar ##### ---

-- Widget separator
theme.separator_text = "|"
--theme.separator_text = " :: "
--theme.separator_text = " • "
-- theme.separator_text = " •• "
theme.separator_fg = x.color8

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
theme.wibar_border_color = x.color0
theme.wibar_border_width = dpi(0)
theme.wibar_border_radius = dpi(0)
theme.wibar_width = dpi(380)

theme.prefix_fg = x.color8

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
