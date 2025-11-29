local config = {}

-- values
config.terminal = "alacritty"
config.editor = os.getenv("EDITOR") or "editor"
config.editor_cmd = config.terminal .. " -e " .. config.editor
config.modkey = "Mod4"

-- keyboard stuff
config.kbd_cfg = {}
config.kbd_cfg.layouts = {
    "fr",
    "us",
    "ara"
}
config.kbd_cfg.current = 1 -- default is 'fr'
config.kbd_cfg.widget = {}

-- theming
config.themes = {
    "j-rice",
    "kwig"
}

config.selected_theme = config.themes[2]

return config
