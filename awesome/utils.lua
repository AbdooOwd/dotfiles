local beautiful = require("beautiful")
local wibox = require("wibox")
local margins = beautiful.margins


-- {{ WIDGETS / UI

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
        top = margins.vertical,
        bottom = margins.vertical,
        left = margins.horizontal,
        right = margins.horizontal,
        widget = wibox.container.margin,
    }
end

-- }}


-- {{ real utils
local function get_thing_length(thing)
    local count = 0
    for _ in pairs(thing) do
        count = count + 1
    end
    return count
end
-- }}


return {
    barcontainer = widget_bar_container,

    vcenter = widget_container_vertical_center,
    hcenter = widget_horizontal_center,

    len = get_thing_length,
}