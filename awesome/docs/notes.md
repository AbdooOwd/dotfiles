# Helpful Notes for AwesomeWM

-   Run `Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome` to test my awesome config
    with terminal output.
-   Widgets and stuff declared and made before the `beautiful.init` function 
    call will mess things up.
    Always Give Priority to `beautiful.init`, kids.
-   Apparently, due to X11 limitations, I cannot change the systray's opacity.
    Thus, I will leave it opaque.

# Ideas

-   I am separating my theme files to have different behavior and look, right?
    And each also includes its own color scheme/palette--usually based on 
    the wallpaper's colors. But what if I change the wallpaper? Will I have to change the theme?
    Every time? Nuh uh! Here comes the idea: like we have separate theme files, we'll
    have separate "color" files. Each will contain a color palette--thus making
    switching colors easier!