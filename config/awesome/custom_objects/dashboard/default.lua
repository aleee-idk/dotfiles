local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local helpers = require("helpers")
local apps = require("apps")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local keygrabber = require("awful.keygrabber")

-- ##### Setup ##### -- {{{

-- Appearance
local box_radius = beautiful.dashboard_box_border_radius or dpi(12)
local box_gap = dpi(6)

local size = {
    small = {
        w = dpi(200),
        h = dpi(200),
    },
    medium = {
        w = dpi(300),
        h = dpi(200),
    },
    large = {
        w = dpi(300),
        h = dpi(350),
    }
}

font = beautiful.font

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

-- Create the widget
dashboard = wibox({
    visible = false,
    ontop = true,
    type = "dock",
    screen = screen.primary,
    bg = beautiful.dashboard_bg or beautiful.exit_screen_bg or beautiful.wibar_bg or beautiful.bg_normal or "#111111",
    fg = beautiful.dashboard_fg or beautiful.exit_screen_fg or beautiful.wibar_fg or beautiful.fg_normal or "#FEFEFE"
})
awful.placement.maximize(dashboard)


-- Add dashboard or mask to each screen
awful.screen.connect_for_each_screen(function(s)
    if s == screen.primary then
        s.dashboard = dashboard
    else
        s.dashboard = helpers.screen_mask(s, dashboard.bg)
    end
end)

local function set_visibility(v)
    for s in screen do
        s.dashboard.visible = v
    end
end

dashboard:buttons(gears.table.join(
-- Right click - Hide dashboard
awful.button({ }, 3, function ()
    dashboard_hide()
end)
))

-- Helper box container -- {{{

-- Helper function that puts a widget inside a box with a specified background color
-- Invisible margins are added so that the boxes created with this function are evenly separated
-- The widget_to_be_boxed is vertically and horizontally centered inside the box
local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(box_radius)
    -- box_container.shape = helpers.prrect(20, true, true, true, true)
    -- box_container.shape = helpers.prrect(30, true, true, false, true)

    local boxed_widget = wibox.widget {
        -- Add margins
        {
            -- Add background color
            {
                -- Center widget_to_be_boxed horizontally
                nil,
                {
                    -- Center widget_to_be_boxed vertically
                    nil,
                    -- The actual widget goes here
                    widget_to_be_boxed,
                    layout = wibox.layout.align.vertical,
                    expand = "none"
                },
                layout = wibox.layout.align.horizontal,
                expand = "none"
            },
            widget = box_container,
        },
        margins = box_gap,
        color = "#FF000000",
        widget = wibox.container.margin
    }

    return boxed_widget
end

-- Helper box container -- }}}

-- ##### Setup ##### -- }}}

-- ##### Widgets ##### -- {{{

-- ***** User widget ***** -- {{{

-- Profile Picture -- {{{

local user_picture = wibox.widget {
    nil,
    {
        {
            image = USER.profile_picture,
            widget = wibox.widget.imagebox
        },
        forced_width = dpi(140),
        forced_height = dpi(140),

        -- Change between circle and boxed profile picture
        -- shape = helpers.prrect(dpi(40),true,true,true,true),
        shape = gears.shape.circle,

        shape_clip = true,
        widget = wibox.container.background
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
}

-- Profile Picture -- }}}

-- User Name -- {{{

local user_text = wibox.widget {
    align = "center",
    valign = "center",
    font = font,
    markup = helpers.colorize_text(os.getenv("USER"):upper(), beautiful.fg_normal),
    widget = wibox.widget.textbox
}

-- User Name -- }}}

-- Host Name -- {{{

local host_text = wibox.widget.textbox()
awful.spawn.easy_async_with_shell("hostnamectl --static", function(out)
    -- Remove trailing whitespaces
    out = out:gsub('^%s*(.-)%s*$', '%1')
    host_text.markup = helpers.colorize_text("@"..out, beutiful.color8)
end)
-- host_text.markup = "<span foreground='" .. x.color8 .."'>" .. minutes.text .. "</span>"
host_text.font = font
host_text.align = "center"
host_text.valign = "center"

-- Host Name -- }}}

-- Uptime -- {{{

local uptime_text = wibox.widget.textbox()
awful.widget.watch("bash -c \"uptime -p | sed 's/^...//'\"", 60, function(_, stdout)
    -- Remove trailing whitespaces
    local out = stdout:gsub('^%s*(.-)%s*$', '%1')
    uptime_text.markup = helpers.colorize_text(out, beautiful.fg_normal)
end)
local uptime = wibox.widget {
    {
        align = "center",
        valign = "center",
        font = font .. " 15",
        markup = helpers.colorize_text(" ", beautiful.fg_normal),
        widget = wibox.widget.textbox()
    },
    {
        align = "center",
        valign = "center",
        font = font .. " 10",
        widget = uptime_text
    },
    layout = wibox.layout.fixed.horizontal
}

-- Uptime -- }}}

local user_widget = wibox.widget {
    user_picture,
    user_text,
    host_text,
    uptime,
    spacing = dpi(15),
    layout = wibox.layout.fixed.vertical
}
local user_box = create_boxed_widget(user_widget, size.large.w, size.large.h, beutiful.background)

-- ***** User widget ***** -- }}}

-- ***** Calendar ***** -- {{{

local calendar = require("custom_objects.widgets.calendar")
-- Update calendar whenever dashboard is shown
dashboard:connect_signal("property::visible", function ()
    if dashboard.visible then
        calendar.date = os.date('*t')
    end
end)

local calendar_box = create_boxed_widget(calendar, size.large.w, size.large.h, beutiful.background)
-- local calendar_box = create_boxed_widget(calendar, 380, 540, x.color0)

-- ***** Calendar ***** -- }}}

-- ***** Disk usage ***** -- {{{

local disk_arc = wibox.widget {
    start_angle = 3 * math.pi / 2,
    min_value = 0,
    max_value = 100,
    value = 50,
    border_width = 0,
    thickness = dpi(10),
    forced_width = dpi(120),
    forced_height = dpi(120),
    rounded_edge = true,
    bg = beutiful.color8.."55",
    colors = { beutiful.color13 },
    widget = wibox.container.arcchart
}

local disk_hover_text_value = wibox.widget {
    align = "center",
    valign = "center",
    font = font .. " 13",
    widget = wibox.widget.textbox()
}

local disk_hover_text = wibox.widget {
    {
        align = "center",
        valign = "center",
        font = font .. " 15",
        markup = helpers.colorize_text("free", beautiful.fg_normal),
        widget = wibox.widget.textbox
    },
    spacing = dpi(2),
    -- visible = false,
    layout = wibox.layout.fixed.vertical
}

local disk_hover= wibox.widget {
    disk_hover_text_value,
    disk_hover_text,
    align = "center",
    valign = "center",
    spacing = dpi(2),
    visible = false,
    layout = wibox.layout.fixed.vertical
}

local disk_percentage = wibox.widget {
    align = "center",
    valign = "center",
    font = font .. " 20",
    widget = wibox.widget.textbox()
}

awesome.connect_signal("evil::disk", function(used, total)
    percentage = used * 100 / total
    disk_arc.value = percentage
    disk_hover_text_value.markup = helpers.colorize_text(tostring(helpers.round(total - used, 1)).."G", beutiful.color4)
    disk_percentage.markup = helpers.colorize_text(tostring(helpers.round(percentage, 2)) .. "%", beautiful.fg_normal)
end)

local disk_icon = wibox.widget {
    align = "center",
    valign = "center",
    font = font .. " 25",
    markup = helpers.colorize_text("", beutiful.color4),
    widget = wibox.widget.textbox()
}

local disk = wibox.widget {
    {
        {
            {
                nil,
                disk_hover,
                expand = "none",
                layout = wibox.layout.align.vertical
            },
            disk_icon,
            disk_arc,
            top_only = false,
            layout = wibox.layout.stack
        },
        helpers.vertical_pad(dpi(24)),
        disk_percentage,
        layout = wibox.layout.fixed.vertical
    },
    valign = "center",
    layout = wibox.layout.fixed.vertical
}

local disk_box = create_boxed_widget(disk, size.small.w, size.small.w, beutiful.background)

disk_box:connect_signal("mouse::enter", function ()
    disk_icon.visible = false
    disk_hover.visible = true
end)
disk_box:connect_signal("mouse::leave", function ()
    disk_icon.visible = true
    disk_hover.visible = false
end)

-- ***** Disk usage ***** -- }}}

-- ***** File system bookmarks ***** -- {{{

local function create_bookmark(name, path, color, hover_color)
    local bookmark = wibox.widget.textbox()
    bookmark.font = "sans bold 16"
    -- bookmark.text = wibox.widget.textbox(name:sub(1,1):upper()..name:sub(2))
    bookmark.markup = helpers.colorize_text(name, color)
    bookmark.align = "center"
    bookmark.valign = "center"

    -- Buttons
    bookmark:buttons(gears.table.join(
    awful.button({ }, 1, function ()
        awful.spawn.with_shell(USER.file_manager.." "..path)
        dashboard_hide()
    end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell(USER.terminal.." -e 'ranger' "..path)
        dashboard_hide()
    end)
    ))

    -- Hover effect
    bookmark:connect_signal("mouse::enter", function ()
        bookmark.markup = helpers.colorize_text(name, hover_color)
    end)
    bookmark:connect_signal("mouse::leave", function ()
        bookmark.markup = helpers.colorize_text(name, color)
    end)

    helpers.add_hover_cursor(bookmark, "hand1")

    return bookmark
end

local bookmarks = wibox.widget {
    spacing = dpi(10),
    layout = wibox.layout.fixed.vertical
}

for dir, path in pairs(USER.dirs) do
    bookmarks:add(create_bookmark(dir, path, beautiful.fg_normal, beautiful.fg_focus))
end

local bookmarks_box = create_boxed_widget(bookmarks, size.medium.w, size.medium.h, beutiful.background)

-- ***** File system bookmarks ***** -- }}}

-- ***** Uptime ***** -- {{{


local uptime_box = create_boxed_widget(uptime, size.small.w, size.small.h, beutiful.background)

uptime_box:buttons(gears.table.join(
awful.button({ }, 1, function ()
    exit_screen_show()
    gears.timer.delayed_call(function()
        dashboard_hide()
    end)
end)
))
helpers.add_hover_cursor(uptime_box, "hand1")

-- ***** Uptime ***** -- }}}

-- ##### Widgets ##### -- }}}

-- ##### Placement ##### -- {{{

-- Item placement
dashboard:setup {
    -- Center boxes vertically
    nil,
    {
        -- Center boxes horizontally
        nil,
        {
            -- Column container
            {
                -- Column 1
                user_box,
                -- fortune_box,
                layout = wibox.layout.fixed.vertical
            },
            {
                -- Column 2
                -- url_petals_box,
                -- notification_state_box,
                -- screenshot_box,
                disk_box,
                bookmarks_box,
                layout = wibox.layout.fixed.vertical
            },
            {
                -- Column 3
                -- corona_box,
                layout = wibox.layout.fixed.vertical
            },
            {
                -- Column 4
                calendar_box,
                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.fixed.horizontal
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.horizontal

    },
    nil,
    expand = "none",
    layout = wibox.layout.align.vertical
}

local dashboard_grabber
function dashboard_hide()
    awful.keygrabber.stop(dashboard_grabber)
    set_visibility(false)
end


local original_cursor = "left_ptr"
function dashboard_show()
    -- Fix cursor sometimes turning into "hand1" right after showing the dashboard
    -- Sigh... This fix does not always work
    local w = mouse.current_wibox
    if w then
        w.cursor = original_cursor
    end
    -- naughty.notify({text = "starting the keygrabber"})
    dashboard_grabber = awful.keygrabber.run(function(_, key, event)
        if event == "release" then return end
        -- Press Escape or q or F1 to hide it
        if key == 'Escape' or key == 'q' or key == 'F1' then
            dashboard_hide()
        end
    end)
    set_visibility(true)
end

-- ##### Placement ##### -- }}}
