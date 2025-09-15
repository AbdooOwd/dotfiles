# TODO

-   Make a correct separator for wibar
-   fix linked variables between files
    -   example: `menubar` should be in `awesome_launcher.lua`.
        but it's used in `rc.lua`
    -   other example: in my `bar/init.lua`, I have a variable
        that holds my "right widgets" (as well as left & center).
        the thing is it assumes the `screen` variable already has
        `systray`. Gotta fix THAT.
-   Put keybinds in separate file
-   :sparkles: tidy the codebase :sparkles:
-   optimize: remove useless imports, requires, and shorten paths
    -   example, instead of importing all of `launcher_module`,
        we import only what we need from it
-   [!] Make everything the most dependable on `theme.lua` as possible
-   Make a place to check Notifications
-   I am making "Generic Widgets", or "Re-usable Widgets" like "popup".
    The thing is that the WiFi and Volume widgets are kinda... generic.
    They both have an icon and their value. Sure, the logic behind them
    is **really** different. But I think I could work out something
    to have a generic widget to bypass this "duplication" and make
    something efficiently re-usable.
-   When making popups, I need to declare the widget as clickable 
    in each widget. There surely is a way to make this more... efficient.
-   Intead of checking for my widget values (Like Wifi & Volume) **constently**,
    I think I should attach it to a signal. Like, for the WiFi, if the wifi switches.
    If it's switched off, or changed, or idk.
-   When switching audio devices (say from HDMI to Bluetooth Earphones), the volume
    value isn't updated.
-   Make a "Windows Style Systray". A button, when clicked: displays tray apps.
-   I made default slider dimensions the ones the volume slider use. Which means
    for every slider I make, I'd be stuck with the volume-slider's "preset".