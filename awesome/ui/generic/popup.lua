local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

---@param title string Pup-up's title
---@param popup_widget table Widget considered to be the pop-up's content
---@param parent_widget table Parent widget of the popup widget. used for placement
local function make_popup(title, popup_widget, parent_widget)
    local popup = awful.popup {
        widget = {
            {
                {
                    text = title,
                    widget = wibox.widget.textbox,
                },
                popup_widget,
                layout = wibox.layout.fixed.vertical,
            },
            margins = 10,
            widget = wibox.container.margin,
        },
        placement = {},
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 3)
        end,
        ontop = true,
        visible = false,
        parent = parent_widget,
    }

    return popup
end

return make_popup