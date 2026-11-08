#!/usr/bin/env bash
set -euo pipefail

export DISPLAY=:1

# Provide the virtual graphical display that Minecraft Workbench launches into.
if ! pgrep -f 'Xvfb :1' >/dev/null 2>&1; then
  Xvfb :1 -screen 0 1280x800x24 -ac >/tmp/cloud-mc-xvfb.log 2>&1 &
fi

for _ in $(seq 1 30); do
  if xdpyinfo -display :1 >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

if ! xdpyinfo -display :1 >/dev/null 2>&1; then
  echo 'Xvfb failed to start; see /tmp/cloud-mc-xvfb.log' >&2
  exit 1
fi

if ! pgrep -x xfce4-session >/dev/null 2>&1; then
  dbus-launch --exit-with-session startxfce4 >/tmp/cloud-mc-xfce.log 2>&1 &
fi

# Keep the raw VNC server loopback-only; Codespaces forwards only the authenticated HTTP port.
if ! pgrep -f 'x11vnc.*5901' >/dev/null 2>&1; then
  x11vnc -display :1 -localhost -nopw -xkb -noxdamage -rfbport 5901 -forever >/tmp/cloud-mc-vnc.log 2>&1 &
fi

if ! pgrep -f 'websockify.*6080' >/dev/null 2>&1; then
  websockify --web /usr/share/novnc 6080 localhost:5901 >/tmp/cloud-mc-novnc.log 2>&1 &
fi

printf 'noVNC desktop is available on forwarded port 6080 (open /vnc.html).\n'
printf 'Minecraft Workbench should launch its game process on DISPLAY=%s.\n' "$DISPLAY"
