#!/usr/bin/env bash
set -euo pipefail

export DISPLAY=:1
export LIBGL_ALWAYS_SOFTWARE=1

# Provide the virtual display where Minecraft Workbench launches the game.
if ! pgrep -x Xvfb >/dev/null 2>&1; then
  nohup Xvfb :1 -screen 0 1280x800x24 -ac +extension GLX +render -noreset \
    >/tmp/cloud-mc-xvfb.log 2>&1 </dev/null &
fi

for _ in $(seq 1 30); do
  if xdpyinfo -display :1 >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

if ! xdpyinfo -display :1 >/dev/null 2>&1; then
  echo 'Xvfb 启动失败，请查看 /tmp/cloud-mc-xvfb.log' >&2
  exit 1
fi

if ! pgrep -x xfce4-session >/dev/null 2>&1; then
  nohup dbus-launch --exit-with-session startxfce4 \
    >/tmp/cloud-mc-xfce.log 2>&1 </dev/null &
fi

# VNC is bound to loopback only. Access it through the authenticated Codespaces-forwarded HTTP port.
if ! pgrep -f '[x]11vnc.*5901' >/dev/null 2>&1; then
  nohup x11vnc -display :1 -localhost -nopw -xkb -noxdamage \
    -rfbport 5901 -forever >/tmp/cloud-mc-vnc.log 2>&1 </dev/null &
fi

if ! pgrep -f '[w]ebsockify.*6080' >/dev/null 2>&1; then
  nohup websockify --web /usr/share/novnc 6080 localhost:5901 \
    >/tmp/cloud-mc-novnc.log 2>&1 </dev/null &
fi

printf '桌面已启动：在 Codespaces 的“端口”面板打开 6080，然后访问 /vnc.html。\n'
printf 'Minecraft Workbench 应在 DISPLAY=%s 上启动游戏。\n' "$DISPLAY"
