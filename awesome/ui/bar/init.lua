-- libraries
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- widgets
local volume_widget = require("ui.bar.widgets.volume")
local wifi_widget = require("ui.bar.widgets.wifi")

-- functions
local the_tasklist = require("ui.bar.tasklist")
local the_taglist = require("ui.bar.taglist")


-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- TODO: move this elsewhere
local separator = wibox.widget {
    markup = '<span font="' .. beautiful.get_font_height(beautiful.font) .. '"> | </span>',
    align  = 'center',
    valign = 'top',
    widget = wibox.widget.textbox
}

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "Main", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create the wibox
    s.mywibox = awful.wibar({ 
        position = "top", 
        screen = s,
        height = 22,
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            the_taglist(s),
            s.mypromptbox,
        },
        { -- Middle widgets
            layout = wibox.layout.flex.horizontal,
            the_tasklist(s),
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wifi_widget,
            separator,
            volume_widget,
            separator,
            mykeyboardlayout,
            separator,
            wibox.widget.systray(),
            separator,
            mytextclock,
            separator,
            s.mylayoutbox,
        },
    }
end)