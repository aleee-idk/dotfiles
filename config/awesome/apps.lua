local awful = require("awful")
local helpers = require("helpers")

local apps = {}

-- ***** Internet ***** -- {{{

apps.browser = function ()
    awful.spawn(user.browser, { switchtotag = true })
end

-- ===== Chats ===== -- {{{

apps.telegram = function ()
    helpers.run_or_rise({class = 'TelegramDesktop'}, false, "telegram", { switchtotag = true})
end

apps.discord = function ()
    helper.run_or_rise({class = 'discord'}, false, "discord")
end

-- ===== Chats ===== -- }}}

-- ***** Internet ***** -- }}}

-- ***** Files ***** -- {{{

apps.file_manager = function ()
    awful.spawn(user.file_manager)
end

apps.file_manager_cli = function ()
    awful.spawn(user.file_manager_cli)
end

-- ***** Files ***** -- }}}

-- ***** Apps for Edit and Create ***** -- {{{

apps.editor = function ()
    helpers.run_or_raise({instance = 'editor'}, true, user.editor, { switchtotag = true})
end

apps.editor_selector = function ()
    helpers.run_or_raise({instance = 'editor'}, true, user.editor_selector, { switchtotag = true})
end

apps.editor_cli = function ()
    helpers.run_or_raise({instance = 'editor_cli'}, true, user.editor_cli, { switchtotag = true})
end

-- ***** Apps for Edit and Create ***** -- }}}

-- ***** Launchers ***** -- {{{

apps.app_launcher = function ()
    awful.spawn.with_shell(user.app_launcher)
end

apps.terminal_selector = function ()
    awful.spawn.with_shell(user.terminal_selector)
end

-- ***** Launchers ***** -- }}}

-- ***** Utilities ***** -- {{{

-- Focused window screenshot
apps.screenshot = function ()
    awful.spawn.with_shell(user.screenshot)
end

-- Gui screenshot
apps.screenshot_gui = function ()
    awful.spawn.with_shell(user.screenshot_gui)
end

-- ***** Utilities ***** -- }}}

-- ***** Configs ***** -- {{{

apps.sound = function ()
    helpers.run_or_rise({class = 'Pavucontrol'}, true, 'pavucontrol')
end

-- ***** Configs ***** -- }}}

-- ***** System ***** {{{

apps.powermenu = function ()
    awful.spawn.with_shell(user.powermenu)
end

-- ***** System ***** }}}

return apps

-- vim:foldmethod=marker
