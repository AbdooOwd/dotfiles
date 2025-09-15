local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

---@param title string Pup-up's title
---@param popup_widget table Widget considered to be the pop-up's content
---@param parent_widget table Parent widget of the popup widget. used for placement
---@param title_align nil (string) alignement of popup's title
local function make_popup(title, popup_widget, parent_widget, title_align)
    title_align = title_align or "left"
    local popup = awful.popup {
        widget = {
            {
                {
                    text = title,
                    align = title_align,
                    widget = wibox.widget.textbox,
                },
                popup_widget,
                layout = wibox.layout.fixed.vertical,
            },
            margins = 10,
            widget = wibox.container.margin,
        },
        placement = {},
        --[[shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 3)
        end,]] -- WE SHALL IGNORE ROUNDED STUFF FOR THIS RICE!!!
        ontop = true,
        visible = false,
        parent = parent_widget,
    }

    return popup
end

return make_popup