local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")

local utils = {}

--[[ For consistency ]]--
local direction_translate = {
    ['up'] = 'top',
    ['down'] = 'bottom',
    ['left'] = 'left',
    ['right'] = 'right'
}
--[[

Return a String with the kind of movement needed for the client.
Return:
- floating
- max
- other

--]]
local function client_status(client)

    local layout = awful.layout.get(mouse.screen)

    if (layout == awful.layout.suit.floating) or (client and client.floating) then
        return "floating"
    end

    if layout == awful.layout.suit.max then
        return "max"
    end

    return "other"

end


--[[

Focus client DWIM (Do What I Mean)
Focus by index if maximized
Focus next screen if on edge
Else Focus client by direction

--]]
function utils.focus_client(direction)

    local client_sts = client_status()

    if client_sts == "floating" or client_sts == "max" then

        if direction == "up" or direction == "left" then
            awful.client.focus.byidx(-1)

        elseif direction == "down" or direction == "right" then
            awful.client.focus.byidx(1)

        end
    elseif client_sts == "other" then
        awful.client.focus.global_bydirection(direction)
    end
end

--[[
Move a floating client to the edges of the screen.
Non floating clients won't be afected,
--]]
function utils.move_to_edge(c, direction)
    local old = c:geometry()
    local new = awful.placement[direction_translate[direction]](c, {honor_padding = true, honor_workarea = true, margins = beautiful.useless_gap * 2, pretend = true})
    if direction == "up" or direction == "down" then
        c:geometry({ x = old.x, y = new.y })
    else
        c:geometry({ x = new.x, y = old.y })
    end
end

--[[

Move client DWIM (Do What I Mean)
Move to edge if the client / layout is floating
Swap by index if maximized
Move to next screen if on edge
Else swap client by direction

--]]
function utils.move_client(client, direction)

    local client_sts = client_status(client)

    if client_sts == "floating" then
        utils.move_to_edge(client, direction)

    elseif client_sts == "max" then

        if direction == "up" or direction == "left" then
            awful.client.swap.byidx(-1, client)

        elseif direction == "down" or direction == "right" then
            awful.client.swap.byidx(1, client)

        end
    elseif client_sts == "other" then
        awful.client.swap.global_bydirection(direction, client, nil)
    end
end

--[[

Move all clients of the focused screen to the equivalent tag
of the screen at the direction.

-]]

function utils.move_tag_to_screen(direction)

    local old_screen = awful.screen.focused()
    local clients = old_screen.clients
    local tag_index = client.focus.first_tag.index

    local new_screen = old_screen:get_next_in_direction(direction)
    local tag = new_screen.tags[tag_index]

    if tag and new_screen then
        for _, c in pairs(clients) do
            c:move_to_tag(tag)
        end
        awful.screen.focus(new_screen)
        tag:view_only()
    end
end

--[[

Return a tag with clients on it
or the tag of the focused screen
This try to mimic I3 behavior on multi screen setups

--]]
function utils.get_tag_with_clients(tag_index)
    local tag
    for s in screen do
        tag = s.tags[tag_index]
        if #tag:clients() ~= 0 then
            return tag
        end
    end

    tag = awful.screen.focused().tags[tag_index]
    return tag
end

--[[

Focus the tag whit clients on it (on any screen)
or the tag of the same screen if don't have any

--]]
function utils.focus_tag(tag_index)

    local tag = utils.get_tag_with_clients(tag_index)

    if not tag then return end

    tag:view_only()

    local _, client = next(tag:clients())

    -- Focus client positioning the mouse on the center
    if client then
        mouse.coords{
            x = client.x + (client.width / 2),
            y = client.y + (client.height / 2)
        }
    end
end

--[[

Move a client to the tag with index "tag_index"

--]]
function utils.move_client_to_tag(tag_index)
    local tag = utils.get_tag_with_clients(tag_index)

    if not tag then return end

    if not client.focus then return end

    local client = client.focus
    client:move_to_tag(tag)

    -- Focus client positioning the mouse on the center
    tag:view_only()
    mouse.coords{
        x = client.x + (client.width / 2),
        y = client.y + (client.height / 2)
    }
end

--[[

Resice Client DWIM
Resize the client by different methods depending the context

--]]
function utils.resize_client(client, direction)
    local floating_resize_factor = 10
    local master_resize_factor = 0.01
    local client_sts = client_status(client)

    if client_sts == "floating" then
        if direction == "up" then
            client:relative_move(0, floating_resize_factor, 0, -floating_resize_factor * 2)
        elseif direction == "down" then
            client:relative_move(0,  -floating_resize_factor, 0, floating_resize_factor * 2)
        elseif direction == "left" then
            client:relative_move(floating_resize_factor, 0, -floating_resize_factor * 2, 0)
        elseif direction == "right" then
            client:relative_move(-floating_resize_factor, 0, floating_resize_factor * 2, 0)
        end

    elseif client then
        if direction == "up" or direction == "right" then
            awful.tag.incmwfact(master_resize_factor)
        elseif direction == "down" or direction == "left" then
            awful.tag.incmwfact(-master_resize_factor)
        end
    end

end

--[[

Adjust audio volume
0 will toggle mute
positive values will increase volume
negative values will decrease volume

--]]
function utils.volume_control(step)
    local cmd
    if step == 0 then
        cmd = "pactl set-sink-mute 0 toggle"
    else

        sign = step > 0 and "+" or ""
        cmd = "pactl set-sink-volume 0 " .. sign .. tostring(step) .. "%"
    end
    awful.spawn.with_shell(cmd)
end

--[[

Rotate the HDMI output.
posible values:
- normal
- left
- right
- inverted

--]]
function utils.rotate_screen(orientation)
    awful.spawn.with_shell("xrandr --output HDMI1 --rotate " .. orientation)
end

--[[

Send action to mpd server

-]]
function utils.mpd_action(action)
    cmd = "mpc " .. action .. " --host " .. USER.mpd_server
    awful.spawn.easy_async_with_shell(cmd,
    function(stdout)
        naughty.notify { text = stdout }
    end)
end

return utils
