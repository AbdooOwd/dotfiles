local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local n = require("naughty").notify

local make_popup = require("ui.generic.popup")
local watch = require("awful.widget.watch")


local use_ALSA = false

local volume_set_command -- always requires "%" after value
local volume_get_command
local mute_get_command

if use_ALSA then
    volume_set_command = "amixer set Master "
    volume_get_command = "amixer sget Master | awk -F\"[][]\" '/Left:/ { print $2 }'"

else
    volume_set_command = "pactl set-sink-volume @DEFAULT_SINK@ " -- space already hardcoded
    volume_get_command = "pactl get-sink-volume @DEFAULT_SINK@;"
    mute_get_command = "pactl get-sink-mute @DEFAULT_SINK@;"
end



local volume_value = nil -- THE VOLUMEEEE
local is_muted = nil

local function update_volume_value()
    awful.spawn.easy_async_with_shell(volume_get_command, function(stdout)
        local volume = tonumber(stdout:match("Volume: front.- (%d+)%%")) or 0
        if volume and volume % 1 == 0 then
            volume_value = volume
        else
            volume_value = -1 --error!!!
        end
    end)
end


local function update_is_muted()
    awful.spawn.easy_async_with_shell(mute_get_command, function(stdout)
        is_muted = stdout:match("Mute: (%a+)") == "yes"
    end)
end




local volume_percentage = wibox.widget.textbox()
volume_percentage.text = "Na%"
local volume_icon = wibox.widget.textbox()
volume_icon.font = beautiful.widget_icon_font

local volume_slider_widget = wibox.widget {
    bar_height = 3,
    handle_width = 5,

    forced_width = beautiful.slider_forced_width,
    forced_height = beautiful.slider_forced_height,

    -- I don't think I need to put these in theme.lua
    minimum = 0,
    maximum = 100,
    value = 50,

    widget = wibox.widget.slider,
}

local volume_widget = wibox.widget {
    {
        volume_icon,
        left = beautiful.margins.widget_icon_left,
        bottom = beautiful.margins.widgets.volume.icon_bottom,
        widget = wibox.container.margin
    },
    {
        volume_percentage,
        widget = wibox.container.background
    },
    spacing = beautiful.widget_icon_spacing,
    layout = wibox.layout.fixed.horizontal
}

local volume_slider_popup = make_popup("Volume Control", volume_slider_widget, volume_widget)


local function update_volume_text_widget()
    if volume_value then
        volume_percentage.text = tostring(volume_value).."%"

        if volume_value > 0 and not is_muted then
            volume_icon.text = "󰕾" -- audio icon
        else
            volume_icon.text = "󰝟" -- no volume icon
        end
    end
end

local function update_volume_slider_widget()
    if volume_value and volume_value ~= volume_slider_widget.value then
        volume_slider_widget.value = volume_value
    end
end


volume_widget:buttons(
    gears.table.join(
        awful.button({}, 1, function()
            awful.placement.next_to(volume_slider_popup,
                {
                    preferred_positions = { "bottom" },
                    preferred_anchors = { "middle" },
                }
            )
            volume_slider_popup.visible = not volume_slider_popup.visible
        end)
    )
)


local new_volume = nil

local volume_debounce_timer = gears.timer {
    timeout = 0.01,
    single_shot = true,
    callback = function()
        if new_volume then
            awful.spawn(volume_set_command .. new_volume .. "%", false)
        end
    end
}


volume_slider_widget:connect_signal("property::value", function(_)
    new_volume = volume_slider_widget.value
    volume_debounce_timer:again()
end)


-- check for volume & mute updates
watch(volume_get_command..mute_get_command, 0.0001, function()
    update_volume_value()
    update_is_muted()
    -- update_volume_slider_widget()
    update_volume_text_widget()
    collectgarbage("collect")
end)

return volume_widget