#!/bin/sh

if [ "${XDG_SESSION_TYPE}" = "wayland" ]; then
	exec electron20 /usr/lib/slack/app.asar --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer,WaylandWindowDecorations --ozone-platform=wayland "$@"
else
	exec electron20 /usr/lib/slack/app.asar "$@"
fi


