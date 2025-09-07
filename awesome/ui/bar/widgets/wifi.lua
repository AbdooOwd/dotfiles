local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local watch = require("awful.widget.watch")
local dpi = beautiful.xresources.apply_dpi

local ssid_command = "iwgetid -r"

local ssid_text = wibox.widget.textbox()
ssid_text.text = "No WiFi"
local wifi_icon = wibox.widget.textbox()
wifi_icon.font = beautiful.widget_icon_font

local ssid_widget = wibox.widget {
    {
        wifi_icon,
        widget = wibox.container.background
    },
    {
        ssid_text,
        widget = wibox.container.background
    },
    spacing = dpi(8),
    layout = wibox.layout.fixed.horizontal,
}

local function update_ssid_text()
    awful.spawn.easy_async_with_shell(ssid_command,
        function(stdout)
            local ssid = stdout:gsub("%s+$", "") -- Remove trailing whitespace/newline
            if ssid == "" then
                ssid = "No WiFi"
                wifi_icon.text = ""
            else
                wifi_icon.text = "󰖩"
            end
            ssid_text.text = ssid
        end)
end

watch(ssid_command, 5, function()
    update_ssid_text()
    collectgarbage("collect")
end)

return ssid_widget