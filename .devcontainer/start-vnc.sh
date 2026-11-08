#!/usr/bin/env bash
set -euo pipefail

export DISPLAY=:1

# Start the virtual X server if it is not already running.
if ! pgrep -x Xvfb >/dev/null 2>&1; then
  Xvfb :1 -screen 0 1280x720x24 >/tmp/xvfb.log 2>&1 &
  sleep 2
fi

# Start XFCE if it has not started.
if ! pgrep -x xfce4-session >/dev/null 2>&1; then
  dbus-launch --exit-with-session startxfce4 >/tmp/xfce4.log 2>&1 &
  sleep 3
fi

# Start VNC and noVNC in the background.
if ! pgrep -x x11vnc >/dev/null 2>&1; then
  x11vnc -display :1 -listen 0.0.0.0 -nopw -xkb -noxdamage -rfbport 5901 -forever >/tmp/x11vnc.log 2>&1 &
fi

if ! pgrep -x websockify >/dev/null 2>&1; then
  websockify --web /usr/share/novnc 6080 localhost:5901 >/tmp/novnc.log 2>&1 &
fi

# Print status
printf '\nDesktop status:\n'
printf ' - noVNC: http://localhost:6080/vnc.html\n'
printf ' - VNC:    localhost:5901\n'
printf ' - Java:   %s\n' "$(java -version 2>&1 | head -n 1)"
