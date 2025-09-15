local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local n = require("naughty").notify

local make_popup = require("ui.generic.popup")
local watch = require("awful.widget.watch")
local dpi = require("beautiful.xresources").apply_dpi


local use_ALSA = false

local volume_set_command -- always requires "%" after value
local volume_get_command
local mute_get_command
local mute_set_command

if use_ALSA then
    volume_set_command = "amixer set Master "
    volume_get_command = "amixer sget Master | awk -F\"[][]\" '/Left:/ { print $2 }'"

else
    volume_set_command = "pactl set-sink-volume @DEFAULT_SINK@ " -- space already hardcoded
    volume_get_command = "pactl get-sink-volume @DEFAULT_SINK@;"
    mute_get_command = "pactl get-sink-mute @DEFAULT_SINK@;"
    mute_set_command = "pactl set-sink-mute @DEFAULT_SINK@ " -- 1: mute / 0: unmute
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

local volume_slider = wibox.widget {
    id = "volume_slider",
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

local volume_popup_mute_button = wibox.widget {
    text = volume_icon.text, -- copy the widget's icon,
    font = beautiful.font_default_name .. " Mono Regular " .. dpi(42),
    forced_height = dpi(20),
    widget = wibox.widget.textbox
}

local volume_popup_widget = wibox.widget {
    {
        volume_popup_mute_button,
        { -- so the mute icon's height affects the container--not the slider's height
            volume_slider, 
            widget = wibox.container.place
        },
        spacing = 10,
        layout = wibox.layout.fixed.horizontal
    },
    valign = "center",
    align = "center",
    widget = wibox.container.place,
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

local volume_popup = make_popup("Volume Control", volume_popup_widget, volume_widget, "center")


local function update_volume_text_widget()
    if volume_value then
        volume_percentage.text = tostring(volume_value).."%"

        if volume_value > 0 and not is_muted then
            volume_icon.text = "󰕾" -- audio icon
        else
            volume_icon.text = "󰝟" -- no volume icon
        end
        volume_popup_mute_button.text = volume_icon.text
    end
end

local function update_volume_popup_widget()
    if volume_value and volume_value ~= volume_popup_widget.value then
        volume_popup_widget.value = volume_value
    end
end


volume_widget:buttons(
    awful.button({}, 1, function()
        awful.placement.next_to(volume_popup,
            {
                preferred_positions = { "bottom" },
                preferred_anchors = { "middle" },
            }
        )
        volume_popup.visible = not volume_popup.visible
    end)
)

volume_popup_mute_button:buttons(
    awful.button({}, 1, function()
        local mute_option
        if is_muted then mute_option = "0" else mute_option = "1" end
        awful.spawn(mute_set_command..mute_option, false)
    end)
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


volume_slider:connect_signal("property::value", function(_)
    new_volume = volume_slider.value
    volume_debounce_timer:again()
end)


-- check for volume & mute updates
watch(volume_get_command..mute_get_command, 0.0001, function()
    update_volume_value()
    update_is_muted()
    -- update_volume_popup_widget()
    update_volume_text_widget()
    collectgarbage("collect")
end)

return volume_widget