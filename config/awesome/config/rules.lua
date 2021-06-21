local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local keys = require("config.keys")

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

    {
        -- All clients will match this rule.
        rule = { },
        properties = {
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
                "files", -- Custom Class for some terminals
                "vimiv", -- image Viewer
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

    -- Start App on Tag

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
    -- Video
    {
        rule_any = {
            class = {
                "mpv",
            },
        },
        properties = {tag = "5"}
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
}
