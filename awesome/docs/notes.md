# Helpful Notes for AwesomeWM

-   Run `Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome` to test my awesome config
    with terminal output.
-   Widgets and stuff declared and made before the `beautiful.init` function 
    call will mess things up.
    Always Give Priority to `beautiful.init`, kids.