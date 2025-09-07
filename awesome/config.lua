local config = {}

config.terminal = "alacritty"
config.editor = os.getenv("EDITOR") or "editor"
config.editor_cmd = config.terminal .. " -e " .. config.editor
config.modkey = "Mod4"

return config
