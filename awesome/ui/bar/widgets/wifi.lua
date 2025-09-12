local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local watch = require("awful.widget.watch")

local make_popup = require("ui.generic.popup")

local ssid_command = "iwgetid -r"

local ssid_text = wibox.widget.textbox()
ssid_text.text = "No WiFi"
local wifi_icon = wibox.widget.textbox()
wifi_icon.font = beautiful.widget_icon_font
wifi_icon.text = "󰖩"


local ssid_widget = wibox.widget {
    {
        wifi_icon,
        left = beautiful.margins.widget_icon_left,
        bottom = beautiful.margins.widgets.wifi.icon_bottom,
        widget = wibox.container.margin,
    },
    {
        ssid_text,
        widget = wibox.container.background
    },
    spacing = beautiful.widget_icon_spacing,
    layout = wibox.layout.fixed.horizontal,
}

local wifi_popup = make_popup("WiFi Control", wibox.widget.textbox("Wifi ye"), ssid_widget)

local function update_ssid_text()
    awful.spawn.easy_async_with_shell(ssid_command,
        function(stdout)
            local ssid = stdout:gsub("%s+$", "") -- Remove trailing whitespace/newline
            if ssid == "" then
                ssid = "No WiFi"
                -- wifi_icon.text = ""
                wifi_icon.visible = false
            else
                -- wifi_icon.text = "󰖩"
                wifi_icon.visible = true
            end
            ssid_text.text = ssid
        end)
end

watch(ssid_command, 5, function()
    update_ssid_text()
    collectgarbage("collect")
end)


ssid_widget:buttons(
    gears.table.join(
        awful.button({}, 1, function()
            --[[awful.placement.next_to(wifi_popup,
                {
                    preferred_positions = { "bottom" },
                    preferred_anchors = { "back" },
                }
            )
            wifi_popup.visible = not wifi_popup.visible]]
            awful.spawn("cinnamon-settings network", false)
        end)
    )
)

return ssid_widget