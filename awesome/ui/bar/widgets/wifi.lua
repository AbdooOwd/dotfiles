local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local ssid_command = "iwgetid -r"

local ssid_text = wibox.widget.textbox()
ssid_text.text = "No WiFi"


local function update_ssid_text()
    awful.spawn.easy_async_with_shell(ssid_command, 
        function(stdout)
            local ssid = stdout:gsub("%s+$", "") -- Remove trailing whitespace/newline
            if ssid == "" then
                ssid = "No WiFi"
            end
            ssid_text.text = ssid
        end)
end

watch(ssid_command, 5, function()
    update_ssid_text()
    collectgarbage("collect")
end)

return ssid_text