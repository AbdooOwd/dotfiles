local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi
local margins = beautiful.margins

-- constants?


--[[
    Takes a widget then centers it vertically
    inside a container
]]
local function widget_container_vertical_center(widget)
    return wibox.widget {
        widget,
        valign = "center",
        widget = wibox.container.place
    }
end




local function widget_horizontal_center(widget)
    return wibox.widget {
        widget,
        haligh = "center",
        widget = wibox.container.place
    }
end

-- default way of displaying widgets in the bar
local function widget_bar_container(widget)
    return wibox.widget {
        widget,
        top = dpi(margins.vertical),
        bottom = dpi(margins.vertical),
        left = dpi(margins.horizontal),
        right = dpi(margins.horizontal),
        widget = wibox.container.margin,
    }
end

return {
    barcontainer = widget_bar_container,

    vcenter = widget_container_vertical_center,
    hcenter = widget_horizontal_center,
}