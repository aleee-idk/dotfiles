local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local titlebars = require("custom_objects.titlebars.minimal")

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- For debugging awful.rules
    -- print('c.class = '..c.class)
    -- print('c.instance = '..c.instance)
    -- print('c.name = '..c.name)

    -- Set every new window as a slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    -- Prevent clients from being unreachable after screen count changes.
    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
        awful.placement.no_overlap(c)
    end

    -- When a client starts up in fullscreen, resize it to cover the fullscreen
    -- a short moment later. Fixes wrong geometry when titlebars are enabled
    if c.fullscreen then
        gears.timer.delayed_call(function()
            if c.valid then
                c:geometry(c.screen.geometry)
            end
        end)
    end

    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        awful.client.property.set(c, 'floating_geometry', c:geometry())
    end

    -- Rounded corners
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
    end

end)

client.connect_signal("mouse::enter", function(c)
    client.focus = c
end)

local function update_client(client, border_color)
    client.border_color = border_color
    if #client.first_tag:clients() > 1 then
        client.border_width = beautiful.border_width
        awful.titlebar.show(client)
    else
        client.border_width = 0
        awful.titlebar.hide(client)
    end
end

client.connect_signal("focus", function(c) pcall(update_client, c, beautiful.border_focus) end)
client.connect_signal("unfocus", function(c) pcall(update_client, c, beautiful.border_normal) end)

--[[
Set mouse resize mode:
live: Resize the layout everytime the mouse moves.
after: Resize the layout only when the mouse is released.
--]]
awful.mouse.resize.set_mode("live")

client.connect_signal("request::titlebars", function(c) titlebars.top(c) end)

----------

-- Restore geometry for floating clients
-- (for example after swapping from tiling mode to floating mode)
-- ==============================================================
tag.connect_signal('property::layout', function(t)
    for k, c in ipairs(t:clients()) do
        if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
            local cgeo = awful.client.property.get(c, 'floating_geometry')
            if cgeo then
                c:geometry(awful.client.property.get(c, 'floating_geometry'))
            end
        end
    end
end)

client.connect_signal('property::geometry', function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        awful.client.property.set(c, 'floating_geometry', c:geometry())
    end
end)

-- ==============================================================
-- ==============================================================

-- When switching to a tag with urgent clients, raise them.
-- This fixes the issue (visual mismatch) where after switching to
-- a tag which includes an urgent client, the urgent client is
-- unfocused but still covers all other windows (even the currently
-- focused window).
-- awful.tag.attached_connect_signal(s, "property::selected", function ()
--     local urgent_clients = function (c)
--         return awful.rules.match(c, { urgent = true })
--     end
--     for c in awful.client.iterate(urgent_clients) do
--         if c.first_tag == mouse.screen.selected_tag then
--             client.focus = c
--         end
--     end
-- end)

-- Raise focused clients automatically
-- client.connect_signal("focus", function(c) c:raise() end)

-- Focus all urgent clients automatically
-- client.connect_signal("property::urgent", function(c)
--     if c.urgent then
--         c.minimized = false
--         c:jump_to()
--     end
-- end)

-- Disable ontop when the client is not floating, and restore ontop if needed
-- when the client is floating again
-- I never want a non floating client to be ontop.
client.connect_signal('property::floating', function(c)
    if c.floating then
        if c.restore_ontop then
            c.ontop = c.restore_ontop
        end
    else
        c.restore_ontop = c.ontop
        c.ontop = false
    end
end)

-- Disconnect the client ability to request different size and position
-- Breaks fullscreen and maximized
-- client.disconnect_signal("request::geometry", awful.ewmh.client_geometry_requests)
-- client.disconnect_signal("request::geometry", awful.ewmh.geometry)

-- Show the dashboard on login
-- Add `touch /tmp/awesomewm-show-dashboard` to your ~/.xprofile in order to make the dashboard appear on login
-- local dashboard_flag_path = "/tmp/awesomewm-show-dashboard"
-- Check if file exists
-- awful.spawn.easy_async_with_shell("stat "..dashboard_flag_path.." >/dev/null 2>&1", function (_, __, ___, exitcode)
--     if exitcode == 0 then
--       -- Show dashboard
--       if dashboard_show then dashboard_show() end
--       -- Delete the file
--       awful.spawn.with_shell("rm "..dashboard_flag_path)
--     end
-- end)

-- Garbage collection
-- Enable for lower memory consumption
-- ===================================================================

-- collectgarbage("setpause", 160)
-- collectgarbage("setstepmul", 400)

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
-- ##### Signals ##### -- }}}
