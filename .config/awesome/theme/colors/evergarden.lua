-- EVERGARDEN PALETTE

local function select_palette(el_theme)
  el_theme.bg_normal     = "#191e21" -- mantle
  el_theme.bg_focus      = "#171c1f" -- crust
  el_theme.bg_urgent     = "#839e9a" -- overlay 2
  el_theme.bg_minimize   = "#00000000" --transparent when minimized
  el_theme.bg_systray    = nil

  el_theme.fg_normal     = "#adc9bc" -- subtext1
  el_theme.fg_focus      = "#f8f9e8" -- text
  el_theme.fg_urgent     = "#ffffff"
  el_theme.fg_minimize   = "#ffffff"

  el_theme.border_width  = 1
  el_theme.border_normal = el_theme.bg_normal
  el_theme.border_focus  = el_theme.bg_focus
  el_theme.border_marked = el_theme.bg_focus

  el_theme.hotkeys_modifiers_fg = "#707070"
end

return select_palette
