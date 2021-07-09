local awful = require("awful")
local helpers = require("helpers")

local apps = {}

-- ***** Internet ***** --

function apps.browser()
    awful.spawn(USER.browser, { switchtotag = true })
end

-- ===== Chats ===== --

apps.telegram = function ()
    helpers.run_or_rise({class = 'TelegramDesktop'}, false, "telegram", { switchtotag = true})
end

function apps.discord()
    helpers.run_or_rise({class = 'discord'}, false, "discord")
end

-- ***** Files ***** --

function apps.file_manager()
    awful.spawn(USER.file_manager)
end

function apps.file_manager_cli()
    awful.spawn(USER.file_manager_cli)
end

-- ***** Apps for Edit and Create ***** --

function apps.editor()
    helpers.run_or_raise({instance = 'editor'}, true, USER.editor, { switchtotag = true})
end

function apps.editor_selector()
    helpers.run_or_raise({instance = 'editor'}, true, USER.editor_selector, { switchtotag = true})
end

function apps.editor_cli()
    helpers.run_or_raise({instance = 'editor_cli'}, true, USER.editor_cli, { switchtotag = true})
end

-- ***** Launchers ***** --

function apps.app_launcher()
    awful.spawn.with_shell(USER.app_launcher)
end

function apps.terminal_selector()
    awful.spawn.with_shell(USER.terminal_selector)
end

function apps.open_bookmark()
    awful.spawn.with_shell(USER.open_bookmark)
end

function apps.password_manager()
    awful.spawn.with_shell(USER.password_manager)
end

-- ***** Utilities ***** --

-- Focused window screenshot
function apps.screenshot()
    awful.spawn.with_shell(USER.screenshot)
end

-- Gui screenshot
function apps.screenshot_gui()
    awful.spawn.with_shell(USER.screenshot_gui)
end

-- Run command
function apps.run_command()
    awful.spawn.with_shell(USER.run_command)
end


-- Run Rofi Scripts 
function apps.run_rofi_scripts()
    awful.spawn.with_shell(USER.run_rofi_scripts)
end

-- ***** Configs ***** --

function apps.sound()
    helpers.run_or_rise({class = 'Pavucontrol'}, true, 'pavucontrol')
end

-- ***** System *****

function apps.powermenu()
    awful.spawn.with_shell(USER.powermenu)
end

return apps

-- vim:foldmethod=syntax
