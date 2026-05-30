local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local function show_islamic_popup()
  local popup

  -- @TODO: Add another textbox for just showing the Next adhan
  awful.spawn.easy_async("bilal all", function(stdout)
    popup = awful.popup {
      widget = {
        {
          text = stdout,
          font = beautiful.font_default_name .. " Regular " .. beautiful.islam.font_size,
          widget = wibox.widget.textbox
        },
        top = beautiful.margins.islam_popup,
        bottom = beautiful.margins.islam_popup,
        left = beautiful.margins.islam_popup,
        right = beautiful.margins.islam_popup,
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
