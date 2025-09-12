local awful = require("awful")
local wibox = require("wibox")

---@param title string Pup-up's title
---@param popup_widget table Widget considered to be the pop-up's content
local function make_popup(title, popup_widget, parent_widget)
    local popup = awful.popup {
        widget = {
            {
                {
                    text = title,
                    widget = wibox.widget.textbox
                },
                popup_widget,
                layout = wibox.layout.fixed.vertical
            },
            margins = 10,
            widget = wibox.container.margin
        },
        placement = {},
        ontop = true,
        visible = false,
        parent = parent_widget
    }

    return popup
end