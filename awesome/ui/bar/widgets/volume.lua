local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local volume_extraction_command = "pactl get-sink-volume @DEFAULT_SINK@; pactl get-sink-mute @DEFAULT_SINK@"

local volume_percentage = wibox.widget.textbox()
volume_percentage.text = "Na%"
local volume_icon = wibox.widget.textbox()
volume_icon.font = beautiful.widget_icon_font

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

local function update_volume_widget()
    awful.spawn.easy_async_with_shell(volume_extraction_command,
        function(stdout)
            local volume_level = stdout:match("Volume: front.- (%d+)%%") or "0"
            local is_muted = stdout:match("Mute: (%a+)") == "yes"
            local volume = tonumber(volume_level)
            if volume and volume % 1 == 0 then
                volume_percentage.text = volume_level.."%"

                if volume > 0 and not is_muted then
                    volume_icon.text = "󰕾" -- audio icon
                else
                    volume_icon.text = "󰝟" -- no volume icon
                end
            end
        end
    )
end

watch(volume_extraction_command, 1, function()
    update_volume_widget()
    collectgarbage("collect")
end)

return volume_widget