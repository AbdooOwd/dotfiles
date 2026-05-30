--------------------------
--  Kwig awesome theme  --
--------------------------

local gears = require("gears")
local naughty = require("naughty")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local this_theme_path = "~/.config/awesome/themes/kwig/"

-- quick vars
local transparent = "#00000000"

local theme = {}

theme.bg_normal     = "#1e1e2e"
theme.bg_focus      = "#181825"
theme.bg_urgent     = "#6c7086"
theme.bg_minimize   = "#00000000" --transparent when minimized
theme.bg_systray    = nil

theme.fg_normal     = "#a6adc8"
theme.fg_focus      = "#cdd6f4"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(0)
theme.border_width  = 1
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_focus

theme.hotkeys_modifiers_fg = "#707070"

--{{ fonts

theme.font_default_name = "FantasqueSansM Nerd Font"
theme.font_default_weight = "Bold"
theme.font_default_size = dpi(25)

theme.font_default_prefix = theme.font_default_name .. " " .. theme.font_default_weight .. " "

theme.widget_icon_font = "FantasqueSansM Nerd Font Mono Regular " .. dpi(45)
theme.widget_icon_spacing = 6 -- spacing between widget value and its icon

theme.font = string.format("%s %s %s",
    theme.font_default_name, theme.font_default_weight, theme.font_default_size)

naughty.config.defaults.font = theme.font_default_prefix .. dpi(25)

theme.hotkeys_font = theme.font_default_prefix .. dpi(23)
theme.hotkeys_description_font = theme.font_default_prefix .. dpi(18)

theme.menu_font_size = dpi(28)

-- }}


-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- taglist stuff
theme.taglist_font_size = dpi(25)
theme.taglist_font = theme.font_default_name .. " Bold " .. tostring(theme.taglist_font_size)
theme.taglist_spacing = dpi(3)

-- Generate taglist squares:
local taglist_square_size = 0
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(25)
theme.menu_width  = dpi(180)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- systray stuff i guess
theme.systray_icon_spacing = 3
theme.systray_base_size = 18


-- tasklist stuff
theme.tasklist_spacing = dpi(3)
-- theme.tasklist_disable_task_name = true
-- theme.tasklist_shape = gears.shape.rounded_rect
-- theme.tasklist_plain_task_name = true

-- wibar stuff
theme.wibar_height = dpi(38)
-- theme.wibar_bg = transparent

-- notifications (naughty)
theme.notification_width = dpi(300)
theme.notification_height = dpi(80)
theme.notification_max_width = dpi(300)
theme.notification_max_height = dpi(200)
theme.notification_icon_size = dpi(30)

-- slider
-- TODO: Oops, that's reserved to the volume's slider
theme.slider_forced_width = dpi(150)
theme.slider_forced_height = dpi(25)

-- titlebar
theme.titlebar_bg = theme.default_bg_color

-- islam !
theme.islam = {}
theme.islam.font_size = dpi(33)

-- {{ margins
theme.margins = {}
theme.margins.universal = dpi(4)
theme.margins.vertical = dpi(3)
theme.margins.horizontal = dpi(3)
theme.margins.widget_icon_left = dpi(6)

theme.margins.tagbutton_horizontal = dpi(4)

-- widget specific margins
theme.margins.widgets = {}

theme.margins.widgets.wifi = {}
theme.margins.widgets.wifi.icon_bottom = dpi(1)

theme.margins.widgets.volume = {}
theme.margins.widgets.volume.icon_bottom = dpi(1.3)
theme.margins.widgets.volume.popup_horizontal = dpi(0)

theme.margins.widgets.systray_button = {}
theme.margins.widgets.systray_button.icon_bottom = dpi(2)

theme.margins.wibar = {}
theme.margins.wibar.horizontal = dpi(3)
theme.margins.wibar.vertical = dpi(3)

theme.margins.islam_popup = dpi(16)
-- }}

-- some more (custom) vars
theme.default_rectangle_radius = 4


-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper = this_theme_path.."mr-totoro-chillin.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
