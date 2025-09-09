local wibox = require("wibox")
local beautiful = require("beautiful")
local n = require("naughty").notify

local el_systray = wibox.widget.systray()
-- el_systray:set_base_size(beautiful.systray_base_size)

local function set_screen_systray(screen)
    screen.systray = el_systray
end

return {
    -- vars
    systray = el_systray,

    -- funcs
    set_screen_systray = set_screen_systray,
}