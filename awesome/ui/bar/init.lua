-- libraries
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("utils")
local dpi = beautiful.xresources.apply_dpi

-- components
local launcher_module = require("ui.bar.launcher_module")
local launcher = launcher_module.launcher

-- widgets
local volume_widget = require("ui.bar.widgets.volume")
local wifi_widget = require("ui.bar.widgets.wifi")
local systray_module = require("ui.bar.widgets.systray_module")

-- functions
local the_tasklist = require("ui.bar.tasklist")
local the_taglist = require("ui.bar.taglist")
local barcontainer = utils.barcontainer
local margin = utils.margin
local len = utils.len


-- Keyboard map indicator and switcher
local kbdcfg = require("config").kbd_cfg
awful.spawn("setxkbmap " .. kbdcfg.layouts[kbdcfg.current])
local mykeyboardlayout = awful.widget.keyboardlayout()
kbdcfg.widget = mykeyboardlayout

-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- TODO: move this elsewhere
local separator = wibox.widget {
    markup = '<span font="' .. beautiful.get_font_height(beautiful.font) .. '"> | </span>',
    valign = "center",
    widget = wibox.widget.textbox
}


-- widget sections
local left_widgets = function(screen)
    return {
        launcher,
        the_taglist(screen),
        layout = wibox.layout.fixed.horizontal
    }
end

local middle_widgets = function(screen)
    return {
        the_tasklist(screen),
        layout = wibox.layout.flex.horizontal
    }
end

local right_widgets = function(screen)
    return {
        barcontainer(wifi_widget),
        barcontainer(volume_widget),
        barcontainer(mykeyboardlayout),
        barcontainer(screen.systray),
        barcontainer(mytextclock),
        layout = wibox.layout.fixed.horizontal
    }
end


awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

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

    -- sets the screen's systray
    systray_module.set_screen_systray(s)

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = 25,
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left Widgets
            layout = wibox.layout.fixed.horizontal,
            left_widgets(s),
            s.mypromptbox,
        },
        middle_widgets(s),
        { -- Right Widgets
            {
                layout = wibox.layout.fixed.horizontal,
                --separator,
                right_widgets(s),
                wibox.container.margin(s.mylayoutbox, dpi(6), dpi(6), dpi(6), dpi(6)),
            },
            valign = "center",
            widget = wibox.container.place
        },
    }
end)
