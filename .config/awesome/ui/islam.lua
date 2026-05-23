local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function show_islamic_popup()
  local popup

  -- @TODO: Add another textbox for just showing the Next adhan
  awful.spawn.easy_async("bilal all", function(stdout)
    popup = awful.popup {
      widget = {
        {
          text = stdout,
          font = beautiful.font_default_name .. " Regular " .. " 20",
          widget = wibox.widget.textbox
        },
        margin = 40,
        widget = wibox.container.margin
      },
      placement = awful.placement.centered,
      ontop = true,
      visible = true
    }
  end)

  local grabber = awful.keygrabber {
    stop_key = "Escape",
    stop_event = "release",
    stop_callback = function()
      popup.visible = false
    end
  }

  grabber:start()
end

return show_islamic_popup
