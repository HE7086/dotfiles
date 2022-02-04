#!/bin/bash

# setting environmental variables under wayland
if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland

    setxkbmap -option caps:escape_shifted_capslock
else
    # fix x11 crashing when relogin from wayland
    unset MOZ_ENABLE_WAYLAND
    unset QT_QPA_PLATFORM
fi

# general environmental variables
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx
export SDL_IM_MODULE=fcitx

export SSH_ASKPASS=/usr/bin/ksshaskpass

export GTK_USE_PORTAL=1

# fix vscode delete freeze
export ELECTRON_TRASH=gio

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org/"

if [[ `cat /etc/hostname` = "HE-workstation" ]]; then
    # machine specific variables for nvidia-vaapi-driver
    export MOZ_DISABLE_RDD_SANDBOX=1
    export MOZ_X11_EGL=1
    export LIBVA_DRIVER_NAME=nvidia
fi
