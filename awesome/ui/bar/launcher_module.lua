local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local config = require("config")

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- Create a launcher widget and a main menu
local myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", config.terminal .. " -e man awesome" },
    { "edit config", config.editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", config.terminal }
local menu_discord = { "open discord", "flatpak run com.discordapp.Discord" }
local menu_utils = {
    "utilities",
    {
        { "Network", "cinnamon-settings network" },
        { "Bluetooth", "cinnamon-settings bluetooth" }
    }
}

local mymainmenu

if has_fdo then
    mymainmenu = freedesktop.menu.build({
        before = { menu_awesome },
        after =  { menu_utils, menu_terminal, menu_discord }
    })
else
    mymainmenu = awful.menu({
        items = {
                menu_awesome,
                { "Debian", debian.menu.Debian_menu.Debian },
                menu_terminal,
                }
    })
end

local el_launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

return {
    launcher = el_launcher,
    menu = mymainmenu
}