local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local volume_extraction_command = "pactl get-sink-volume @DEFAULT_SINK@;"

local volume_text = wibox.widget.textbox()
volume_text.text = "Na%"


local function update_volume_text()
    awful.spawn.easy_async_with_shell(volume_extraction_command,
        function(stdout)
            local volume_level = stdout:match("Volume: front.- (%d+)%%") or "0"

            if volume_level then
                volume_text.text = volume_level.."%"
            end
        end)
end

watch(volume_extraction_command, 1, function()
    update_volume_text()
    collectgarbage("collect")
end)

return volume_text