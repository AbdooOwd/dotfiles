local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi

local menu_button = wibox.widget {
  text = " 󰍜  ",
  font = beautiful.font_default_prefix  .. beautiful.menu_font_size,
  widget = wibox.widget.textbox
}

local menu_awesome = require("ui.bar.widgets.menu_awm")
local visible = false

menu_button:buttons(gears.table.join(
  menu_button:buttons(),
  awful.button({}, 1, nil,
    function()
      if visible == false then
        menu_awesome:show()
        visible = true
      else
        menu_awesome:hide()
        visible = false
      end
    end
  )
))

return menu_button
