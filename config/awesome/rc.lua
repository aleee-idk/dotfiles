-- Main file --
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")

-- Hide tmux keybinds from the hotkeys popup
package.loaded['awful.hotkeys_popup.keys.tmux'] = {}

local auto_start = true
-- local auto_start = false

-- ***** Variables ***** -- {{{

-- ##### User Variables ##### -- {{{

USER = {
    profile_picture = os.getenv("HOME").."/.config/awesome/themes/user.jpg",
    terminal = "kitty -1",

    -- Rofi script to open terminal in custom path
    terminal_selector = os.getenv("HOME") .. "/dotfiles/scripts/rofi/open_terminal.sh",

    browser = os.getenv("HOME") .. "/dotfiles/scripts/rofi/rofi_buku",
    file_manager = "thunar",
    file_manager_cli = "kitty -1 --class files -e ranger",
    editor = "code",
    editor_cli = "kitty -1 --class editor -e nvim",

    -- Rofi script to open the editor in custom path
    editor_selector = os.getenv("HOME") .. "/dotfiles/scripts/rofi/edit_file.sh",

    screenshot = "sleep 0.5 && scrot -ub /tmp/screenshot-$(date +%F_%T).png -e 'xclip -selection c -t image/png < $f'",
    screenshot_gui = "flameshot gui",

    -- Launchers --
    app_launcher = "~/.config/rofi/launchers/misc/launcher.sh",

    mpd = "kitty -1 --class music -e ncmpcpp",
    mpd_server = "10.0.0.10",

    powermenu = os.getenv("HOME") .. "/dotfiles/config/rofi/applets/menu/powermenu.sh",

    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
        music = os.getenv("XDG_MUSIC_DIR") or "~/Music",
        pictures = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
        videos = os.getenv("XDG_VIDEOS_DIR") or "~/Videos",
        -- Make sure the directory exists so that your screenshots
        -- are not lost
        --     screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "~/Pictures/Screenshots",
    },
    sidebar = {
        hide_on_mouse_leave = true,
        show_on_mouse_screen_edge = true,
    },

    -- >> Lock screen <<
    -- This password will ONLY be used if you have not installed
    -- https://github.com/RMTT/lua-pam
    -- as described in the README instructions
    -- Leave it empty in order to unlock with just the Enter key.
    -- lock_screen_custom_password = "",
    lock_screen_custom_password = "awesome",

    -- >> Battery <<
    -- You will receive notifications when your battery reaches these
    -- levels.
    battery_threshold_low = 20,
    battery_threshold_critical = 5,

}

awful.util.shell = "/usr/bin/bash"

-- ##### User variables ##### -- }}}

-- ##### Themes ##### -- {{{

awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.magnifier,
    awful.layout.suit.max,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- ================================================== --

local themes = {
    "default",
}

local theme = themes[1]

-- ================================================== --

local decoration_themes = {
    "default"
}

local decoration_theme = decoration_themes[1]

-- ================================================== --

local bar_themes = {
    "default"
}

local bar_theme = bar_themes[1]

-- ================================================== --

local sidebar_themes = {
    "default"
}

local sidebar_theme = sidebar_themes[1]

-- ================================================== --

local notification_themes = {
    "default"
}

local notification_theme = notification_themes[1]

-- ================================================== --

local icon_themes = {
    "default"
}

local icon_theme = icon_themes[1]

-- ================================================== --

local dashboard_themes = {
    "default"
}

local dashboard_theme = dashboard_themes[1]

-- ================================================== --

local exit_screen_themes = {
    "default"
}

local exit_screen_theme = exit_screen_themes[1]

-- ##### Themes ##### -- }}}

-- ***** Variables ***** -- }}}

--***** Initialization ***** -- {{{

-- ##### Theme handling ##### -- {{{

local xrdb = beautiful.xresources.get_current_theme()
-- Make dpi function global
dpi = beautiful.xresources.aplly_dpi
-- Make xresources colors global
x = {
    --           xrdb variable
    background = xrdb.background,
    foreground = xrdb.foreground,
    color0     = xrdb.color0,
    color1     = xrdb.color1,
    color2     = xrdb.color2,
    color3     = xrdb.color3,
    color4     = xrdb.color4,
    color5     = xrdb.color5,
    color6     = xrdb.color6,
    color7     = xrdb.color7,
    color8     = xrdb.color8,
    color9     = xrdb.color9,
    color10    = xrdb.color10,
    color11    = xrdb.color11,
    color12    = xrdb.color12,
    color13    = xrdb.color13,
    color14    = xrdb.color14,
    color15    = xrdb.color15,
}

-- Load AwesomeWM libraries
require("awful.autofocus")

-- Default notification libray

-- Load theme
local theme_dir = "~/.config/awesome/themes/".. theme .. "/"
beautiful.init(theme_dir .. "theme.lua")

-- ##### Theme handling ##### -- }}}

-- ##### Features ##### -- {{{

-- Icons
-- local icons = require("icons")
-- icons.init(icon_theme)

-- Keybinds and mousebinds
local keys = require("keys")

-- Notification daemons and notification theme
-- local notifications = require("notifications")
-- notifications.init(notification_theme)

-- Windows decoration theme and custom decorations
-- local decorations = require("decorations")
-- decorations.init(decoration_theme)

-- Helper functions
local helpers = require("helpers")

-- ================================================== --
-- Desktop Components --

-- Status bar(s)
require("custom_objects.bars." .. bar_theme)

-- -- Exit screen
require("custom_objects.exit_screen." .. exit_screen_theme)

-- -- Sidebar
-- require("custom_objects.sidebar." .. sidebar_theme)

-- -- Dashboard
require("custom_objects.dashboard." .. dashboard_theme)

-- -- Lock screen
-- local lock_screen = require("custom_objects.lock_screen")
-- lock_screen.init()

-- -- App drawer
-- require("custom_objects.app_drawer")

-- Window switcher
require("custom_objects.window_switcher")

-- -- Toggle-able microphone overlay
-- require("custom_objects.microphone_overlay")

-- ================================================== --
-- -- Daemons --
require("daemons_utils")

-- ================================================== --
-- Layouts
awful.layout.layout = layouts

-- Wallpaper
-- ===================================================================
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        -- local wallpaper = beautiful.wallpaper
        -- -- If wallpaper is a function, call it with the screen
        -- if type(wallpaper) == "function" then
        --     wallpaper = wallpaper(s)
        -- end

        -- >> Method 1: Built in wallpaper function
        gears.wallpaper.fit(beautiful.wallpaper, s)
        gears.wallpaper.maximized(beautiful.wallpaper, s)

        -- >> Method 2: Set theme's wallpaper with feh
        --awful.spawn.with_shell("feh --bg-fill " .. wallpaper)

        -- >> Method 3: Set last wallpaper with feh
        -- awful.spawn.with_shell(os.getenv("HOME") .. "/.fehbg")
    end
end
-- Set wallpaper (I do it via script)
-- awful.screen.connect_for_each_screen(function(s)
--     -- Wallpaper
--     set_wallpaper(s)
-- end)

-- ##### Features ##### -- }}}

-- ##### Tags ##### {{{

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table
    local l = awful.layout.suit

    -- Layouts for each tag
    local layouts = {
        l.spiral.dwindle, -- 1 --
        l.spiral.dwindle, -- 2 --
        l.spiral.dwindle, -- 3 --
        l.spiral.dwindle, -- 4 --
        l.spiral.dwindle, -- 5 --
        l.spiral.dwindle, -- 6 --
        l.spiral.dwindle, -- 7 --
        l.spiral.dwindle, -- 8 --
        l.max,            -- 9 --
        l.spiral.dwindle  -- 0 --
    }

    -- Tag names
    local tagnames = beautiful.tagnames or {
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10"
    }

    -- Create all tags with global config
    awful.tag(tagnames, s, layouts)

    -- Create tags with seperate configuration for each tag
    -- awful.tag.add(tagnames[1], {
    --     layout = layouts[1],
    --     screen = s,
    --     master_width_factor = 0.6,
    --     selected = true,
    -- })
    -- ...
end)

-- ##### Tags ##### }}}

-- ##### Rules ##### -- {{{

-- Floatin windows configuration

local floating_client_placement = function(c)
    -- If the layout is floating or there are no other visible
    -- clients, center client
    if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating or #mouse.screen.clients == 1 then
        return awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
    end

    -- Else use this placement
    local p = awful.placement.no_overlap + awful.placement.no_offscreen
    return p(c, {honor_padding = true, honor_workarea=true, margins = beautiful.useless_gap * 2})
end

local centered_client_placement = function(c)
    return gears.timer.delayed_call(function ()
        awful.placement.centered(c, {honor_padding = true, honor_workarea=true})
    end)
end

-- Rules to apply to new clients (through the "manage" signal).

awful.rules.rules = {

    --- Clients windows configuration {{{

    {
        -- All clients will match this rule.
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.client_keys,
            buttons = keys.client_buttons,
            -- screen = awful.screen.preferred,
            screen = awful.screen.focused,
            size_hint_honor = false,
            honor_padding = true,
            maximized = false,
            titlebars_enabled = beautiful.titlebars_enabled,
            maximized_horizontal = false,
            maximized_vertial = false,
            placement = floating_client_placement
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
                "Devtools", -- Firefox devtools
            },
            class = {
                "Thunar",
                "Godot",
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "files",
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            },
        },
        properties = { floating = true, ontop = true },
    },

    -- Fullscreen Clients
    {
        rule_any = {
            class = {

            },
            instance = {

            },
        },
        properties = { fullscreen = true }
    },

    -- Centered Clients
    {
        rule_any = {
            type = {
                "dialog",
            },
            class = {
                "Steam",
                "discord",
                "music",
                "scratchpad",
            },
            instance = {
                "music",
                "scratchpad",
            }
        },
        properties = { placement = centered_client_placement },
    },

    -- Tilebars OFF (explicitly)
    {
        rule_any = {
            type = {
                "splash",
            },
            class = {

            },
            instance = {

            },
        },
        callback = function(c)
            decorations.hide(c)
        end
    },

    -- Tilebars ON (explicitly)
    {
        rule_any = {
            type = {
                "dialog",
            },
            role = {
                "conversation",
            },
        },
        callback = function(c)
            decorations.show(c)
        end
    },

    -- "Needy": Jump to client when they are urgents
    {
        rule_any = {
            type = {
                "dialog",
            },
            class = {
                "firefox",
            },
        },
        callback = function(c)
            c:connect_signal("property::urgent", function ()
                if c.urgent then
                    c:jump_to()
                end
            end)
        end
    },

    -- Fixed terminal geometry for floating terminals
    -- {
    --     rule_any = {
    --         class = {
    --             "Alacritty",
    --             "Termite",
    --             "mpvtube",
    --             "kitty",
    --             "st-256color",
    --             "st",
    --             "URxvt",
    --         },
    --     },
    --     properties = { width = screen_width * 0.45, height = screen_height * 0.5 }
    -- },

    --- Clients windows configuration }}}

    --- Start Apps on Tag {{{

    -- Browsers
    {
        rule_any = {
            class = {
                "firefox",
            },
        },
        except_any = {
            role = { "GtkFileChooserDialog" },
            instance = { "Toolkit" },
            type = { "dialog" },
        },
        properties = { screen = 1, tag = awful.screen.focused().tags[1]},
    },

    -- Games
    {
        rule_any = {
            class = {
                "factorio",
            },
            instance = {

            },
        },
        properties = { screen = 1, tag = awful.screen.focused().tags[7]},
    },

    -- Chat
    {
        rule_any = {
            class = {
                "TelegramDesktop",
                "whatsapp-nativefier-d40211",
                "discord"
            },
        },
        properties = { screen = 2, tag = "9"}
    },

    -- Music
    {
        rule_any = {
            class = {
                "music",
                "Spotify",
            },
        },
        properties = {tag = "10"}
    },

    -- U' Stuff
    {
        rule_any = {
            class = {
                "Microsoft Teams"
            },
        },
        properties = { screen = 2, tag = "8"}
    },
    --- Start Apps on Tag }}}
}


-- ##### Rules ##### -- }}}

-- ##### Autostart ##### {{{


auto_start_apps = {
    os.getenv("HOME") .. "/dotfiles/scripts/master.sh",
    "telegram-desktop",
    "whatsapp-nativefier",
    "discord",
    USER.mpd,
}

if auto_start then
    for app = 1, #auto_start_apps do
        awful.spawn(auto_start_apps[app])
    end
end

-- ##### Autostart ##### }}}

-- ##### Error Handling ##### -- {{{

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
        title = "Oops, an error happened!",
        text = tostring(err) })
        in_error = false
    end)
end

-- ##### Error Handling ##### -- }}}

-- ##### Signals ##### -- {{{

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- For debugging awful.rules
    -- print('c.class = '..c.class)
    -- print('c.instance = '..c.instance)
    -- print('c.name = '..c.name)

    -- Set every new window as a slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    -- if awesome.startup
    -- and not c.size_hints.user_position
    -- and not c.size_hints.program_position then
    --     -- Prevent clients from being unreachable after screen count changes.
    --     awful.placement.no_offscreen(c)
    --     awful.placement.no_overlap(c)
    -- end

end)

client.connect_signal("mouse::enter", function(c)
    client.focus = c
end)

-- When a client starts up in fullscreen, resize it to cover the fullscreen a short moment later
-- Fixes wrong geometry when titlebars are enabled
client.connect_signal("manage", function(c)
    if c.fullscreen then
        gears.timer.delayed_call(function()
            if c.valid then
                c:geometry(c.screen.geometry)
            end
        end)
    end
end)

-- if beautiful.border_width > 0 then
--     client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
--     client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- end

-- Set mouse resize mode (live or after)
awful.mouse.resize.set_mode("live")

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

client.connect_signal('manage', function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        awful.client.property.set(c, 'floating_geometry', c:geometry())
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

-- ***** Initialization ***** -- }}}

-- vim:foldmethod=marker
