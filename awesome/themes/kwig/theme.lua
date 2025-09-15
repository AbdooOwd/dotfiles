---------------------------
-- Kwig awesome theme --
---------------------------

local gears = require("gears")

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local this_theme_path = "~/.config/awesome/themes/kwig/"

-- quick vars
local transparent = "#00000000"

local theme = {}


theme.wibar_opacity_hex = "D5"
theme.default_opacity_hex = "D0"
theme.default_bg_color = "#1A221C"

theme.bg_normal     = theme.default_bg_color --.. theme.default_opacity_hex
theme.bg_focus      = "#212B24" --.. theme.default_opacity_hex
theme.bg_urgent     = "#ff0000" --.. theme.default_opacity_hex
theme.bg_minimize   = "#444444" --.. theme.default_opacity_hex
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"


--{{ fonts

theme.font_default_name = "FantasqueSansM Nerd Font"
theme.font_default_weight = "Bold"
theme.font_default_size = dpi(14)

theme.widget_icon_font = "FantasqueSansM Nerd Font Mono Regular 21"
theme.widget_icon_spacing = dpi(6) -- dpi spacing between widget value and its icon

theme.font = string.format("%s %s %s", 
    theme.font_default_name, theme.font_default_weight, theme.font_default_size)

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

-- Generate taglist squares:
local taglist_square_size = dpi(4)
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
theme.menu_height = dpi(20)
theme.menu_width  = dpi(200)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- systray stuff i guess
theme.systray_icon_spacing = dpi(2)
theme.systray_base_size = dpi(20)

-- taglist stuff
theme.taglist_font_size = dpi(15)
theme.taglist_font = theme.font_default_name .. " Bold " .. tostring(theme.taglist_font_size)

-- tasklist stuff
theme.tasklist_bg_focus = "#212B24" .. theme.default_opacity_hex
theme.tasklist_bg_normal = transparent
-- theme.tasklist_disable_task_name = true
-- theme.tasklist_shape = gears.shape.rounded_rect
-- theme.tasklist_plain_task_name = true

-- wibar stuff
theme.wibar_bg = "#1A221C" .. theme.wibar_opacity_hex

-- slider
-- TODO: Oops, that's reserved to the volume's slider
theme.slider_forced_width = dpi(200)
theme.slider_forced_height = dpi(25)

-- titlebar
theme.titlebar_bg = theme.default_bg_color .. theme.default_opacity_hex


-- {{ margins
theme.margins = {}
theme.margins.vertical = dpi(4)
theme.margins.horizontal = dpi(4)
theme.margins.widget_icon_left = dpi(6)

theme.margins.tagbutton_horizontal = dpi(8)

-- widget specific margins
theme.margins.widgets = {}

theme.margins.widgets.wifi = {}
theme.margins.widgets.wifi.icon_bottom = dpi(1.9)

theme.margins.widgets.volume = {}
theme.margins.widgets.volume.icon_bottom = dpi(2)
theme.margins.widgets.volume.popup_horizontal = dpi(0)

theme.margins.widgets.systray_button = {}
theme.margins.widgets.systray_button.icon_bottom = dpi(2)
-- }}


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

theme.wallpaper = this_theme_path.."ghibli-forest.jpg"

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
