local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local config = require("config")

local el_menu = require("ui.bar.widgets.menu_awm")
local el_launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = el_menu })

return {
    launcher = el_launcher,
    menu = el_menu
}
