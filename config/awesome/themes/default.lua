local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi
local gfs = require("gears.filesystem")

local colors = require("themes.colors.tokyonight")

local theme_name = "default"

local themes_path = gfs.get_themes_dir()


local theme = {}

-- ##### Colors font and Wallpaper ##### ---

theme.font = "CaskaydiaCove Nerd Font"

-- Color with little transparency
theme.bg_transparent = "#000000"

theme.bg_dark       = colors.bg_dark
theme.bg_normal     = colors.bg
theme.bg_occupied   = colors.blue
theme.bg_focus      = colors.green2
theme.bg_urgent     = colors.red
theme.bg_minimize   = colors.bg
theme.bg_systray    = colors.bg

theme.systray_icon_spacing = dpi(5)

theme.fg_normal     = colors.fg
theme.fg_occupied   = colors.fg
theme.fg_focus      = colors.fg
theme.fg_urgent     = colors.fg
theme.fg_minimize   = colors.fg
theme.fg_systray    = colors.fg


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
theme.border_radius = dpi(0)

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
theme.notification_opacity = 0.75

-- Borders
theme.notification_border_width = dpi(2)
theme.notification_border_radius = theme.border_radius
theme.notification_border_color = theme.notification_fg

-- Edge snap
-- TODO: Figure out where this is used

theme.snap_shape = gears.shape.rectangle
theme.snap_bg = theme.foreground
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
theme.separator_fg = theme.fg_normal

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
theme.wibar_border_color = theme.fg_normal
theme.wibar_border_width = dpi(0)
theme.wibar_border_radius = dpi(0)
theme.wibar_width = dpi(380)

theme.prefix_fg = theme.fg_normal

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
