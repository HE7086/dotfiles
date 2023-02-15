#!/bin/sh

if [ "${XDG_SESSION_TYPE}" = "wayland" ]; then
	exec electron21 /usr/lib/slack/app.asar --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer,WaylandWindowDecorations --ozone-platform=wayland --enable-wayland-ime "$@"
else
	exec electron21 /usr/lib/slack/app.asar "$@"
fi


