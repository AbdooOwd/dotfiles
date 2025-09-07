local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

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


--[[
    5 dpi margin on the left & right for the widget
]]
local function widget_container_default_side_margin(widget)
    return wibox.widget {
        widget,
        left = dpi(5),
        right = dpi(5),
        widget = wibox.container.margin
    }
end

--[[
    The common container for widgets.
    centered vertically, side-margins
]]
local function widget_common_container(widget)
    return widget_container_default_side_margin(
        widget_container_vertical_center(widget)
    )
end

local function widget_horizontal_center(widget)
    return wibox.widget {
        widget,
        haligh = "center",
        widget = wibox.container.place
    }
end

local function widget_bar_container(widget)
    return wibox.widget {
        widget,
        top = dpi(4),
        bottom = dpi(4),
        left = dpi(8),
        right = dpi(8),
        widget = wibox.container.margin,
    }
end

local function widget_new_margin(widget, left, right, top, bottom)
    return wibox.widget {
        widget,
        left = left,
        right = right,
        top = top,
        bottom = bottom,
        widget = wibox.container.margin
    }
end

return {
    container_sidemargin = widget_container_default_side_margin,
    common_container = widget_common_container,

    barcontainer = widget_bar_container,

    vcenter = widget_container_vertical_center,
    hcenter = widget_horizontal_center,
    margin = widget_new_margin
}