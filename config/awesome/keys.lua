local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local xrandr = require("xrandr")
local helpers = require("helpers")
local utils = require("utils")
local apps = require("apps")

local keys = {}

-- Mod Keys
local modkey = "Mod4"
local altKey = "Mod1"
local ctrlKey = "Control"


-- ##### Mouse keybindings ##### -- {{{

-- ===== Desktop Actions ===== -- {{{
keys.desktop_buttons = gears.table.join(

-- Right Click -- {{{
awful.button({ }, 3,
function ()
    if dashboard_show then
        dashboard_show()
    end
end
),
-- Right Click -- }}}

-- Side buttons -- {{{
awful.button({ }, 9, awful.tag.viewprev),
awful.button({ }, 8, awful.tag.viewnext)
-- Side buttons -- }}}

)

-- ===== Desktop Actions ===== -- }}}

-- ===== Whole clients ===== -- {{{

keys.client_buttons = gears.table.join(

-- Left Click -- Move client
awful.button({ }, 1, function(c) client.focus = c end),

-- Mod Left Click -- move client
awful.button({ modkey }, 1,
function(c)
    local c = mouse.object_under_pointer()
    client.focus = c
    awful.mouse.client.move(c)
end
),

-- Middle Click --
-- awful.button({ modkey }, 2, function(c) c:kill() = c end),

-- Right Click --
awful.button({ modkey }, 3,
function(c)
    client.focus = c
    awful.mouse.client.resize(c)
end
)

)

-- ===== Whole clients ===== -- }}}

-- ===== Title bars ===== -- {{{

keys.titlebar_buttons = gears.table.join(
-- Left button - move
awful.button({ }, 1, function()
    local c = mouse.object_under_pointer()
    client.focus = c
    awful.mouse.client.move(c)
end),

-- Middle button - close
awful.button({ }, 2, function ()
    local c = mouse.object_under_pointer()
    c:kill()
end),

-- Right button - resize
awful.button({ }, 3, function()
    local c = mouse.object_under_pointer()
    client.focus = c
    awful.mouse.client.resize(c)
    -- awful.mouse.resize(c, nil, {jump_to_corner=true})
end),

-- Side button up - toggle floating
awful.button({ }, 9, function()
    local c = mouse.object_under_pointer()
    client.focus = c
    --awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
    c.floating = not c.floating
end),

-- Side button down - toggle ontop
awful.button({ }, 8, function()
    local c = mouse.object_under_pointer()
    client.focus = c
    c.ontop = not c.ontop
    -- Double Tap - toggle sticky
    -- local function single_tap()
    --   c.ontop = not c.ontop
    -- end
    -- local function double_tap()
    --   c.sticky = not c.sticky
    -- end
    -- helpers..single_double_tap(single_tap, double_tap)
end)
)

-- ===== Title bars ===== -- }}}

-- ===== Taglist widget ===== -- {{{

keys.taglist_buttons = gears.table.join(
awful.button({ }, 1, function(t)
    -- t:view_only()
    helpers.tag_back_and_forth(t.index)
end),
awful.button({ superkey }, 1, function(t)
    if client.focus then
        client.focus:move_to_tag(t)
    end
end),
-- awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ }, 3, function(t)
    if client.focus then
        client.focus:move_to_tag(t)
    end
end),
awful.button({ superkey }, 3, function(t)
    if client.focus then
        client.focus:toggle_tag(t)
    end
end),
awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
)

-- ===== Taglist widget ===== -- }}}

-- ##### Mouse keybindings ##### -- }}}

-- ##### Keys keybindings ##### -- {{{

-- ===== Global keys ===== -- {{{

keys.global_keys = gears.table.join(

-- ***** Layaout ***** --- {{{

-- Focus client Vim way -- {{{
awful.key({ modkey }, "h",
function ()
    utils.focus_client("left")
end,
{ description = "Focus left", group = "Clients" }
),
awful.key({ modkey }, "j",
function ()
    utils.focus_client("down")
end,
{ description = "Focus down", group = "Clients" }
),
awful.key({ modkey }, "k",
function ()
    utils.focus_client("up")
end,
{ description = "Focus up", group = "Clients" }
),
awful.key({ modkey }, "l",
function ()
    utils.focus_client("right")
end,
{ description = "Focus right", group = "Clients" }
),
awful.key({ modkey }, "Left",
function ()
    utils.focus_client("left")
end,
{ description = "Focus left", group = "Clients" }
),
awful.key({ modkey }, "Down",
function ()
    utils.focus_client("down")
end,
{ description = "Focus down", group = "Clients" }
),
awful.key({ modkey }, "Up",
function ()
    utils.focus_client("up")
end,
{ description = "Focus up", group = "Clients" }
),
awful.key({ modkey }, "Right",
function ()
    utils.focus_client("right")
end,
{ description = "Focus right", group = "Clients" }
),
-- Focus client Vim way -- }}}

-- Focus clients by index -- {{{
awful.key({ modkey }, "z",
function()
    awful.client.focus.byidx(1)
end,
{ description = "Focus next by index", group = "Clients" }
),
awful.key({ modkey, "Shift" }, "z",
function()
    awful.client.focus.byidx(-1)
end,
{ description = "Focus previous by index", group = "Clients" }
),
-- Focus clients by index -- }}}

-- Move Tag to Screen -- {{{

awful.key({ modkey, ctrlKey }, "h",
function ()
    utils.move_tag_to_screen("left")
end,
{ description = "Move Tag to screen on the left", group = "Screens" }
),

awful.key({ modkey, ctrlKey }, "j",
function ()
    utils.move_tag_to_screen("down")
end,
{ description = "Move Tag to screen on the bottom", group = "Screens" }
),

awful.key({ modkey, ctrlKey }, "k",
function ()
    utils.move_tag_to_screen("up")
end,
{ description = "Move Tag to screen on the top", group = "Screens" }
),

awful.key({ modkey, ctrlKey }, "l",
function ()
    utils.move_tag_to_screen("right")
end,
{ description = "Move Tag to screen on the right", group = "Screens" }
),

awful.key({ modkey, ctrlKey }, "Left",
function ()
    utils.move_tag_to_screen("left")
end,
{ description = "Move Tag to screen on the left", group = "Screens" }
),

awful.key({ modkey, ctrlKey }, "Down",
function ()
    utils.move_tag_to_screen("down")
end,
{ description = "Move Tag to screen on the bottom", group = "Screens" }
),

awful.key({ modkey, ctrlKey }, "Up",
function ()
    utils.move_tag_to_screen("up")
end,
{ description = "Move Tag to screen on the top", group = "Screens" }
),

awful.key({ modkey, ctrlKey }, "Right",
function ()
    utils.move_tag_to_screen("right")
end,
{ description = "Move Tag to screen on the right", group = "Screens" }
),

-- move Tag to Screen -- }}}

-- Window switcher -- {{{
awful.key({ altKey }, "Tab",
function ()
    window_switcher_show(awful.screen.focused())
end,
{ description = "Activate window switcher", group = "Clients"}
),
-- Window switcher -- }}}

-- Layout switcher -- {{{
awful.key({ modkey }, "Tab",
function()
    awful.layout.inc(1)
end,
{ description = "Next layout", group = "Layouts"}
),

awful.key({ modkey, "Shift"}, "Tab",
function()
    awful.layout.inc(-1)
end,
{ description = "Previous layout", group = "Layouts"}
),
-- Layout switcher -- }}}

-- Toggle floating -- {{{
awful.key({ modkey, "Shift" }, "space",
function(c)
    if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating then
        awful.client.floating.toggle()
    end
end,
{ description = "Toggle floating for focused client", group = "Clients"}
),
-- Toggle floating -- }}}

-- Gasp -- {{{
awful.key({ modkey }, "plus",
function()
    awful.tag.incgap(5, nil)
end,
{ description = "Increment gaps size for current tag", group = "Gaps"}
),
awful.key({ modkey }, "minus",
function()
    awful.tag.incgap(-5, nil)
end,
{ description = "Increment gaps size for current tag", group = "Gaps"}
),
-- Gasp -- }}}

-- Resize clients -- {{{
awful.key({ modkey, altKey }, "h",
function(c)
    helpers.resize_dwim(client.focus, "left")
end,
{ description = "Resize client on left side", group = "Clients"}
),
awful.key({ modkey, altKey }, "j",
function(c)
    helpers.resize_dwim(client.focus, "down")
end,
{ description = "Resize client on bottom side", group = "Clients"}
),
awful.key({ modkey, altKey }, "k",
function(c)
    helpers.resize_dwim(client.focus, "up")
end,
{ description = "Resize client on top side", group = "Clients"}
),
awful.key({ modkey, altKey }, "l",
function(c)
    helpers.resize_dwim(client.focus, "right")
end,
{ description = "Resize client on right side", group = "Clients"}
),
awful.key({ modkey, altKey }, "Left",
function(c)
    helpers.resize_dwim(client.focus, "left")
end,
{ description = "Resize client on left side", group = "Clients"}
),
awful.key({ modkey, altKey }, "Down",
function(c)
    helpers.resize_dwim(client.focus, "down")
end,
{ description = "Resize client on bottom side", group = "Clients"}
),
awful.key({ modkey, altKey }, "Up",
function(c)
    helpers.resize_dwim(client.focus, "up")
end,
{ description = "Resize client on top side", group = "Clients"}
),
awful.key({ modkey, altKey }, "Right",
function(c)
    helpers.resize_dwim(client.focus, "right")
end,
{ description = "Resize client on right side", group = "Clients"}
),
-- Resize clients -- }}}

-- N° master / columns {{{
awful.key({ modkey, "Shift" }, "plus",
function()
    awful.tag.incnmaster(1, nil, true)
end,
{ description = "Increase the number of master clients", group = "Layouts"}
),
awful.key({ modkey, "Shift" }, "minus",
function()
    awful.tag.incnmaster(-1, nil, true)
end,
{ description = "Decrease the number of master clients", group = "Layouts"}
),
awful.key({ modkey, ctrlKey }, "plus",
function()
    awful.tag.incncol(1, nil, true)
end,
{ description = "Increase the number of master clients", group = "Layouts"}
),
awful.key({ modkey, ctrlKey }, "minus",
function()
    awful.tag.incncol(-1, nil, true)
end,
{ description = "Decrease the number of master clients", group = "Layouts"}
),
-- N° master / columns }}}

-- Urgent or Undo -- {{{
-- Jump to urgent client or the last one
awful.key({ modkey }, "u",
function()
    uc = awful.client.urgent.get()
    if uc == nil then
        awful.tag.history.restore()
    else
        awful.client.urgent.jumpto()
    end
end,
{ description = "Jump to urgent or last client", group = "Clients" }
),
-- Urgent or Undo -- }}}

-- Unminimize clients -- {{{
awful.key({ modkey, "Shift" }, "n",
function ()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
        c:emit_signal(
        "request::activate", "key.unminimize", {raise = true}
        )
    end
end,
{description = "Restore minimized", group = "Clients"}),
-- Unminimize clients -- }}}

-- ***** Layaout ***** --- }}}

-- ***** Spawners ***** -- {{{

-- Terminal -- {{{

-- Just open a terminal in $HOME
awful.key({ modkey }, "Return",
function()
    awful.spawn(user.terminal)
end,
{ description = "Spawn terminal", group = "Spawners"}
),


-- Open terminal in given path
awful.key({ modkey, "Shift"}, "Return", apps.terminal_selector,
{ description = "Spawn terminal", group = "Spawners"}
),

-- Terminal -- }}}

-- Apps Launchers -- {{{

awful.key({ modkey }, "d",
apps.app_launcher,
{ description = "Application Launcher", group = "Spawners"}
),

-- Apps Launchers -- }}}

-- File Manager -- {{{

awful.key({ modkey }, "f",
apps.file_manager,
{ description = "GUI File Manager", group = "Spawners"}
),

awful.key({ modkey, "Shift" }, "f",
apps.file_manager_cli,
{ description = "CLI File Manager", group = "Spawners"}
),

-- File Manager -- }}}

-- Editors -- {{{


awful.key({ modkey }, "e",
apps.editor_selector,
{ description = "Application Launcher", group = "Spawners"}
),

-- Editors -- }}}

-- ***** Spawners ***** -- }}}

-- ***** System Stuff ***** -- {{{

-- Brightness -- {{{
awful.key({ }, "XF86MonBrightnessUp",
function()
    awful.spawn_with_shell("xbacklight -inc 1")
end,
{ description = "Increase brightness", group = "System Stuff"}
),
awful.key({ }, "XF86MonBrightnessDown",
function()
    awful.spawn_with_shell("xbacklight -dec 1")
end,
{ description = "Decrease brightness", group = "System Stuff"}
),
-- Brightness -- }}}

-- Volume -- {{{
awful.key({ }, "XF86AudioRaiseVolume",
function()
    helpers.volume_control(5)
end,
{ description = "Increase volume", group = "System Stuff"}
),
awful.key({ }, "XF86AudioLowerVolume",
function()
    helpers.volume_control(-5)
end,
{ description = "Decrease volume", group = "System Stuff"}
),
awful.key({ }, "XF86AudioMute",
function()
    helpers.volume_control(0)
end,
{ description = "(Un)Mute volume", group = "System Stuff"}
),
-- Volume -- }}}

-- Media -- {{{
awful.key({ }, "XF86AudioPlay",
function()
    awful.spawn_with_shell("playerctl play")
end,
{ description = "Media play ", group = "System Stuff"}
),
awful.key({ }, "XF86AudioPause",
function()
    awful.spawn_with_shell("playerctl pause")
end,
{ description = "Media pause ", group = "System Stuff"}
),
awful.key({ }, "XF86AudioNext",
function()
    awful.spawn_with_shell("playerctl next")
end,
{ description = "Media next ", group = "System Stuff"}
),
awful.key({ }, "XF86AudioPrev",
function()
    awful.spawn_with_shell("playerctl previous")
end,
{ description = "Media previous ", group = "System Stuff"}
),
-- Media -- }}}

-- Screenshot -- {{{
awful.key({ }, "Print",
apps.screenshot,
{ description = "Screenshot of focused window", group = "System Stuff"}
),
awful.key({ "Shift" }, "Print",
apps.screenshot_gui,
{ description = "Screenshot GUI editor", group = "System Stuff"}
),
-- Screenshot -- }}}
--
-- Screens {{{
awful.key({modkey}, "Home",
function()
    xrandr.xrandr()
end,
{ description = "Screen Config", group = "System Stuff"}
),
-- Screens }}}

-- Power Menu -- {{{

-- awful.key({ modkey }, "Escape",
-- function()
--     exit_screen_show()
-- end,
-- { description = "Quit awesome/system", group="Awesome Stuff" }
-- ),

awful.key({ modkey }, "Escape",
apps.powermenu,
{ description = "Quit awesome/system", group="Awesome Stuff" }
),

-- Power Menu -- }}}

-- ***** System Stuff ***** -- }}}

-- ***** Awesome stuff ***** -- {{{

-- Show Dashboard
awful.key({ modkey, "Control"}, "d",
function ()
    if dashboard_show then
        dashboard_show()
    end
end,
{ description = "Show Dashboard", group = "Awesome Stuff" }
),
-- Reload Awesome --
awful.key({ modkey, "Shift" }, "r",
awesome.restart,
{ description = "Reload awesome", group = "Awesome Stuff"}
),


-- Show keybindings --
awful.key({ modkey, "Shift" }, "s", hotkeys_popup.show_help,
{ description = "Show this help", group="Awesome Stuff" }
)

-- ***** Awesome stuff ***** -- }}}

)

-- ===== Global keys ===== -- }}}

-- ===== Client keys ===== -- {{{

keys.client_keys = gears.table.join(

-- Move Clients -- {{{
awful.key({ modkey, "Shift" }, "h",
function (c)
    utils.move_client(c, "left")
end,
{ description = "Move client to left", group = "Clients" }
),
awful.key({ modkey, "Shift" }, "j",
function (c)
    utils.move_client(c, "down")
end,
{ description = "Move client to down", group = "Clients" }
),
awful.key({ modkey, "Shift" }, "k",
function (c)
    utils.move_client(c, "up")
end,
{ description = "Move client to up", group = "Clients" }
),
awful.key({ modkey, "Shift" }, "l",
function (c)
    utils.move_client(c, "right")
end,
{ description = "Move client to right", group = "Clients" }
),
awful.key({ modkey, "Shift" }, "Left",
function (c)
    utils.move_client(c, "left")
end,
{ description = "Move client to left", group = "Clients" }
),
awful.key({ modkey, "Shift" }, "Down",
function (c)
    utils.move_client(c, "down")
end,
{ description = "Move client to down", group = "Clients" }
),
awful.key({ modkey, "Shift" }, "Up",
function (c)
    utils.move_client(c, "up")
end,
{ description = "Move client to up", group = "Clients" }
),
awful.key({ modkey, "Shift" }, "Right",
function (c)
    utils.move_client(c, "right")
end,
{ description = "Move client to right", group = "Clients" }
),
-- Move Clients -- }}}

-- Center client -- {{{
awful.key({ modkey, ctrlKey }, "space",
function(c)
    awful.placement.centered(c, { honor_workarea = true, honor_padding = true })
    helpers.float_and_resize(c, c.screen.geometry.width * 0.65, c.screen.geometry.height * 0.9)
end,
{ description = "Set client in float mode", group = "Clients"}
),
-- Center client -- }}}

-- Toggle title bars -- {{{

awful.key({ modkey }, "t",
function(c)
    decoration.cycle(c)
end,
{ description = "Toggle titlebar for focused client", group = "Clients"}
),
awful.key({ modkey, "Shift" }, "t",
function(c)
    local clients = awful.screen.focused().clients
    for _, c in pairs(clients) do
        decoration.cycle(c)
    end
end,
{ description = "Toggle titlebar for all clients", group = "Clients"}
),
-- Toggle title bars -- }}}

-- Close clients -- {{{
awful.key({ modkey, "Shift" }, "q",
function(c)
    c:kill()
end,
{ description = "Close client", group = "Clients"}
),
-- Close clients -- }}}

-- Set master -- {{{
awful.key({ modkey, ctrlKey }, "Return",
function(c)
    c:swap(awful.client.getmaster())
end,
{ description = "Set focused client as master", group = "Clients"}
),
-- Set master -- }}}

-- Pin client -- {{{
-- Keep on top
awful.key({ modkey, "Shift" }, "p",
function(c)
    c.ontop = not c.ontop
end,
{ description = "Toggle keep on top on focused client", group = "Clients"}
),

-- Sticky
awful.key({ modkey, ctrlKey }, "p",
function(c)
    c.sticky = not c.sticky
end,
{ description = "Toggle sticky on focused client", group = "Clients"}
),
-- Pin client -- }}}

-- Minimize client -- {{{
awful.key({ modkey }, "n",
function(c)
    c.minimized = true
end,
{ description = "Minimize client", group = "Clients"}
),
-- Minimize client -- }}}

-- (Un)Maximize client -- {{{
awful.key({ modkey }, "m",
function(c)
    c.maximized = not c.maximized
end,
{ description = "(Un)Maximize client", group = "Clients"}
),
awful.key({ modkey, "Shift" }, "m",
function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
end,
{ description = "(Un)Maximize client vertically", group = "Clients"}
),
awful.key({ modkey, ctrlKey }, "m",
function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
end,
{ description = "(Un)Maximize client horizontally", group = "Clients"}
)
-- (Un)Maximize client -- }}}
)

-- ===== Client keys ===== -- }}}

-- ##### Keys keybindings ##### -- }}}

-- ##### Tags keybindings ##### -- {{{

-- Bind all key numbers to tags. Be careful: we use keycodes to make it work on any keyboard layout. This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do

    keys.global_keys = gears.table.join(keys.global_keys,

    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
    function ()
        utils.focus_tag(i)
    end,
    {description = "View tag #"..i, group = "Tags"}),

    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
    function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end,
    {description = "Toggle tag #" .. i, group = "Tags"}),

    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
    function ()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end,
    {description = "move focused client to tag #"..i, group = "Tags"}),

    -- View Tag of next screen.
    awful.key({ modkey, altKey }, "#" .. i + 9,
    function ()
        if screen:count() <= 1 then return end

        awful.screen.focus_relative(1)
        local tag = awful.screen.focused().tags[i]
        if tag then
            tag:view_only()
        end
    end,
    {description = "Toggle focused client on tag #" .. i, group = "Tags"})
    )
end

-- ##### Tags keybindings ##### -- }}}

-- Set root (desktop) keys

root.keys(keys.global_keys)
root.buttons(keys.desktop_buttons)

return keys

-- vim:foldmethod=marker
