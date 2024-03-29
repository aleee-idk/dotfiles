-- Main file --
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Hide tmux keybinds from the hotkeys popup
package.loaded['awful.hotkeys_popup.keys.tmux'] = {}

-- ##### User Variables ##### --

--[[
Return the terminal as a string.
@tparam app string The aplication to open in the terminal.
@tparam class string The class to give to the terminal.
@treturn string The formated string with the terminal, class and aplication to run with awful.spawn_with_shell().
--]]
local function terminal(app, class)
    local terminal = "kitty -1"

    if class then terminal = terminal .. " --class " .. class end
    if app then terminal = terminal .. " -e " .. app end

    return terminal
end

USER = {
    profile_picture = os.getenv("HOME") .. "/.config/awesome/themes/user.jpg",
    terminal = terminal(),

    -- Rofi script to open terminal in custom path
    terminal_selector = os.getenv("HOME") ..
        "/dotfiles/scripts/rofi/open_terminal",

    browser = os.getenv("HOME") .. "/dotfiles/scripts/rofi/rofi_buku",
    file_manager = "thunar",
    file_manager_cli = terminal("ranger", "files"),
    editor = "code",
    editor_cli = terminal("nvim", "editor"),

    -- Rofi script to open the editor in custom path
    editor_selector = os.getenv("HOME") .. "/dotfiles/scripts/rofi/edit_file",

    screenshot = "sleep 0.5 && scrot -ub /tmp/screenshot-$(date +%F_%T).png -e 'xclip -selection c -t image/png < $f'",
    screenshot_gui = "flameshot gui",

    -- Launchers --
    app_launcher = "rofi -no-lazy-grab -show drun -modi drun -theme " ..
        os.getenv("HOME") .. "/.config/rofi/themes/fullscreen_transparent.rasi",

    mpd = terminal("ncmpcpp", "music"),
    mpd_server = "10.0.0.10",

    powermenu = "rofi -show p -modi p:rofi-power-menu -i -theme " ..
        os.getenv("HOME") .. "/.config/rofi/themes/sidebar.rasi",
    run_command = os.getenv("HOME") .. "/dotfiles/scripts/rofi/exec_command",
    run_rofi_scripts = os.getenv("HOME") ..
        "/dotfiles/scripts/run_rofi_scripts.sh",
    open_bookmark = os.getenv("HOME") .. "/dotfiles/scripts/rofi/buku",
    password_manager = "bwmenu",

    -- >> Battery <<
    -- You will receive notifications when your battery reaches these
    -- levels.
    battery_threshold_low = 20,
    battery_threshold_critical = 5,

    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
        music = os.getenv("XDG_MUSIC_DIR") or "~/Music",
        pictures = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
        videos = os.getenv("XDG_VIDEOS_DIR") or "~/Videos"
        -- Make sure the directory exists so that your screenshots
        -- are not lost
        --     screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "~/Pictures/Screenshots",
    }
}

THEME = {
    theme = os.getenv("HOME") .. "/.config/awesome/themes/default.lua",
    bar = "custom_objects.bars.default"
}

local auto_start_apps = {
    -- Lock Screen
    "discord", os.getenv("HOME") .. "/.fehbg"
}

awful.util.shell = "/usr/bin/bash"

-- ##### Themes ##### --

require("awful.autofocus")
beautiful.init(THEME.theme)
require(THEME.bar)

-- ##### Wallpaper ##### --
-- In case you need it, if you don't manage the wallpaper by your own

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end

        -- >> Method 1: Built in wallpaper function
        -- gears.wallpaper.fit(beautiful.wallpaper, s)
        -- gears.wallpaper.maximized(beautiful.wallpaper, s)

        -- >> Method 2: Set theme's wallpaper with feh
        -- awful.spawn.with_shell("feh --bg-fill " .. wallpaper)

        -- >> Method 3: Set last wallpaper with feh
        awful.spawn.with_shell(os.getenv("HOME") .. "/.fehbg")
        -- awful.spawn.with_shell("wal -n -R")
    end
end

-- ##### Tags ##### --

awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle, awful.layout.suit.tile,
    awful.layout.suit.tile.left, awful.layout.suit.magnifier,
    awful.layout.suit.max, awful.layout.suit.floating
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

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
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
        l.max, -- 8 --
        l.spiral.dwindle, -- 9 --
        l.spiral.dwindle -- 0 --
    }

    -- Tag names
    local tagnames = beautiful.tagnames or
                         {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"}

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

-- ##### Error Handling ##### --

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

-- ##### General Config ##### --

awful.rules.rules = require("config.rules")
require("config.signals")

-- ##### Autostart Apps #####

awesome.connect_signal("startup", function()
    for app = 1, #auto_start_apps do
        awful.spawn.once(auto_start_apps[app], awful.rules.rules)
    end
end)
