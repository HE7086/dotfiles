#!/bin/bash

# append_path () {
#     case ":$PATH:" in
#         *:"$1":*)
#             ;;
#         *)
#             PATH="${PATH:+$PATH:}$1"
#     esac
# }
# append_path "$HOME/.local/bin"

export KDEHOME="$HOME/.config/kde"

# setting environmental variables under wayland
if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
else
    # fix x11 crashing when relogin from wayland
    unset MOZ_ENABLE_WAYLAND
    unset QT_QPA_PLATFORM
    unset _JAVA_AWT_WM_NONREPARENTING
fi

setxkbmap -option caps:escape_shifted_capslock

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export INPUT_METHOD=fcitx
export SDL_IM_MODULE=fcitx

export SSH_ASKPASS=/usr/bin/ksshaskpass

# fix vscode delete freeze
export ELECTRON_TRASH=gio

# eval $(ssh-agent)
# eval $(gnome-keyring-daemon --start)
# export SSH_AUTH_SOCK

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org https://repo.archlinuxcn.org"

if [[ $(cat /etc/hostname) = "HE-workstation" ]]; then
    if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then 
        export EGL_PLATFORM=wayland
        # export GDK_SCALE=2
    else
        export MOZ_X11_EGL=1
    fi

    # export GTK_USE_PORTAL=1
    # machine specific variables for nvidia-vaapi-driver
    export MOZ_DISABLE_RDD_SANDBOX=1
    export LIBVA_DRIVER_NAME=nvidia
    export NVD_BACKEND=direct
fi

if [[ $(cat /etc/hostname) = "HE-TP" ]]; then
    # export MOZ_DISABLE_RDD_SANDBOX=1
    export LIBVA_DRIVER_NAME=iHD

    export OPENCV_LOG_LEVEL=ERROR
fi
