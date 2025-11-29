local awful = require("awful")
local gears = require("gears")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local config = require("config")
local utils = require("utils")
local launcher_menu = require("ui.bar.launcher_module").menu

local globalkeys = gears.table.join(
    awful.key({ config.modkey,           }, "#39"--[[s]],      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ config.modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ config.modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ config.modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ config.modkey,           }, "#44"--[[j]],
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ config.modkey,           }, "#45"--[[k]],
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ config.modkey,           }, "#52"--[[w]], function () launcher_menu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ config.modkey, "Shift"   }, "#44"--[[j]], function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ config.modkey, "Shift"   }, "#45"--[[k]], function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ config.modkey, "Control" }, "#44"--[[j]], function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ config.modkey, "Control" }, "#45"--[[k]], function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ config.modkey,           }, "#30"--[[u]], awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ config.modkey,           }, "#55"--[[v]],
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ config.modkey,           }, "Return", function () awful.spawn(config.terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ config.modkey, "Control" }, "#27"--[[r]], awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ config.modkey, "Shift"   }, "#38"--[[q]], awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ config.modkey,           }, "#46"--[[l]],     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ config.modkey,           }, "#43"--[[h]],     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ config.modkey, "Shift"   }, "#43"--[[h]],     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ config.modkey, "Shift"   }, "#46"--[[l]],     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ config.modkey, "Control" }, "#43"--[[h]],     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ config.modkey, "Control" }, "#46"--[[l]],     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ config.modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ config.modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ config.modkey, "Control" }, "#57"--[[n]],
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ config.modkey },            "27"--[[r]],     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ config.modkey }, "#53"--[[x]],
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ config.modkey }, "#33"--[[p]], function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),

    -- Abdoo's Custom
    awful.key({ config.modkey }, "#56"--[[b]], function() awful.spawn("rofi -show drun") end,
        { description = "runs rofi", group="launcher"}),

    awful.key( { config.modkey }, "Tab", function() awful.spawn("rofi -show window") end,
        { description = "[rofi] displays active windows", group = "launcher" }),

    -- requires 'xscreensaver' + its extra data, and 'fortune' installed
    awful.key( { config.modkey, "Control" }, "#33"--[[p]],
    function() awful.spawn("/usr/libexec/xscreensaver/phosphor --scale 3 --program fortune") end,
        { description = "xscreensaver's phosphor", group = "fun" }),

    -- open calculator
    awful.key( { config.modkey }, "#54"--[[c]], function() awful.spawn("gnome-calculator") end,
        { description = "calculator", group = "misc" }),

    -- change keyboard layout
    awful.key( { config.modkey }, "#42",
        function() -- TODO: Should turn this into a utils.lua func
            local kbdcfg = config.kbd_cfg
            kbdcfg.current = kbdcfg.current % #(kbdcfg.layouts) + 1
            local new_layout = kbdcfg.layouts[kbdcfg.current]
            os.execute("setxkbmap -layout " .. new_layout .. "")
        end,
        { description = "switches keyboard layout",  group = "misc"}
    )
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ config.modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ config.modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ config.modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ config.modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end


return globalkeys