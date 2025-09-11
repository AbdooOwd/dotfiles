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