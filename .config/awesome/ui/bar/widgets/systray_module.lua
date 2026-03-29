local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local make_popup = require("ui.generic.popup")


local systray_toggle_button = wibox.widget {
    {
        id = "systray_toggle_button",
        text = "󰜰", -- down-arrow icon,
        font = beautiful.widget_icon_font,
        widget = wibox.widget.textbox
    },
    bottom = beautiful.margins.widgets.systray_button.icon_bottom,
    widget = wibox.container.margin
}

local el_systray = wibox.widget {
    {
        id = "el_systray",
        widget = wibox.widget.systray
    },
    widget = wibox.container.background
}

local systray_popup = make_popup("Systray", el_systray, systray_toggle_button)


local function set_screen_systray(screen)
    screen.systray = el_systray
    screen.systray_button = systray_toggle_button
end

systray_toggle_button:buttons(
    gears.table.join(
        awful.button({}, 1, function()
            awful.placement.next_to(systray_popup,
                {
                    preferred_positions = { "bottom" },
                    preferred_anchors = { "middle" },
                }
            )
            systray_popup.visible = not systray_popup.visible
        end)
    )
)

return {
    -- vars
    systray = el_systray,
    systray_button = systray_toggle_button,

    -- funcs
    set_screen_systray = set_screen_systray,
}