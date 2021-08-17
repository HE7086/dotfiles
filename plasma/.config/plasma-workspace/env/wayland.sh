#!/bin/bash

# setting environmental variables under wayland
if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland

    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export INPUT_METHOD=fcitx
    export SDL_IM_MODULE=fcitx

    setxkbmap -option caps:escape_shifted_capslock
else
    # fix x11 crashing when relogin from wayland
    unset MOZ_ENABLE_WAYLAND
    unset QT_QPA_PLATFORM
fi
