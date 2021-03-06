local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local helpers = require("helpers")
local keys = require("config.keys")

local battery_widget = require("widgets.battery-widget.battery")
local volume_widget = require("widgets.volume-widget.volume")


-- ##### Widgets ##### --


-- Helper function that updates a taglist item
local update_taglist = function (item, tag, index)
	if tag.selected then
		item.bg = beautiful.tag_bg_focused
		item.fg = beautiful.tag_fg_focused
	elseif tag.urgent then
		item.bg = beautiful.tag_bg_urgent
		item.fg = beautiful.tag_fg_urgent
	elseif #tag:clients() > 0 then
		item.bg = beautiful.tag_bg_occupied
		item.fg = beautiful.tag_fg_occupied
	else
		item.bg = beautiful.tag_bg
		item.fg = beautiful.tag_fg
	end
end

-- ===== Bar Widgets ===== --

awful.screen.connect_for_each_screen(
	function(s)

		-- ***** Taglist ***** --

		s.mytaglist = awful.widget.taglist {
			screen = s,

			-- wich tags to include, all, selected or noempty
			filter = awful.widget.taglist.filter.noempty,
			buttons = keys.taglist_buttons,
			widget_template = {
				{
					{
						id     = 'text_role',
						widget = wibox.widget.textbox,
					},
					left   = 10,
					right  = 10,
					top    = 3,
					bottom = 3,
					widget = wibox.container.margin
				},
				id     = 'background_role',
				shape              = gears.shape.circle,
				widget             = wibox.container.background,
				create_callback = function(self, tag, index, _)
					update_taglist(self, tag, index)
				end,
				update_callback = function(self, tag, index, _)
					update_taglist(self, tag, index)
				end,
			},
		}

		-- ***** Clock ***** --

		s.clock = wibox.widget.textclock("%I:%M")

		s.toggle_bar = wibox.widget {
			text = " ",
			font = beautiful.font .. " 15",
			widget = wibox.widget.textbox,
		}

		helpers.add_hover_cursor(s.toggle_bar, "hand1")

		-- ***** Layouts ***** ---

		s.mylayoutbox = awful.widget.layoutbox(s)


		-- ***** Main Bar ***** ---
		s.main_bar = awful.wibar({
			screen = s,
			visible = true,
			ontop = false,
			position = beautiful.wibar_position,
			-- height = 20,
			bg = beautiful.wibar_bg,
			fg = beautiful.wibar_fg,
		})

		local bar_widgets = {}
		bar_widgets[1] = {
			id = "main",
			layout = wibox.layout.align.horizontal,
			{
				layout = wibox.layout.align.horizontal,
				s.mytaglist,
			},
			{
				layout = wibox.layout.align.horizontal,
			},
			{
				volume_widget(),
				battery_widget({
					show_current_level = true,
					display_notification = true
				}),
				s.clock,
				s.mylayoutbox,
				s.toggle_bar,
				spacing = dpi(5),
				layout = wibox.layout.fixed.horizontal,
			},
		}

		bar_widgets[2] = {
			id = "second",
			layout = wibox.layout.align.horizontal,
			{
				layout = wibox.layout.align.horizontal,
			},
			{
				layout = wibox.layout.align.horizontal,
				expand = "none",
				nil,
				wibox.widget.systray(),
				nil,
			},
			{
				layout = wibox.layout.fixed.horizontal,
				s.toggle_bar,
			},
		}

		local return_main_widgets_timer = gears.timer {
			timeout   = 60,
			single_shot = true,
			callback  = function()
				s.main_bar : setup (bar_widgets[1])
				s.main_bar.bg = beautiful.wibar_bg
			end
		}

		local function cycle_bar()
			local id = s.main_bar:get_children_by_id("main")

			if id then
				s.main_bar : setup (bar_widgets[2])
				s.main_bar.bg = beautiful.bg_systray
				return_main_widgets_timer:start()
			else
				s.main_bar : setup (bar_widgets[1])
				s.main_bar.bg = beautiful.wibar_bg
				return_main_widgets_timer:stop()
			end
		end

		s.main_bar:setup(bar_widgets[1])

		s.toggle_bar:buttons(gears.table.join(
			-- Middle click - Hide traybox
			awful.button({ }, 1, function ()
				cycle_bar()
			end)
		))

	end
)

-- vim:foldmethod=syntax
