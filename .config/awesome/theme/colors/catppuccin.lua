-- CATPPUCCIN PALETTE

local function select_palette(el_theme)
  el_theme.bg_normal     = "#1e1e2e"
  el_theme.bg_focus      = "#181825"
  el_theme.bg_urgent     = "#6c7086"
  el_theme.bg_minimize   = "#00000000" --transparent when minimized
  el_theme.bg_systray    = nil

  el_theme.fg_normal     = "#a6adc8"
  el_theme.fg_focus      = "#cdd6f4"
  el_theme.fg_urgent     = "#ffffff"
  el_theme.fg_minimize   = "#ffffff"

  el_theme.border_width  = 1
  el_theme.border_normal = el_theme.bg_normal
  el_theme.border_focus  = el_theme.bg_focus
  el_theme.border_marked = el_theme.bg_focus

  el_theme.hotkeys_modifiers_fg = "#707070"
end

return select_palette
