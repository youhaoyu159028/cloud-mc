#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.local/share/minecraft" "$HOME/.local/bin" "$HOME/Desktop"

cat > "$HOME/Desktop/open-novnc.sh" <<'EOF'
#!/usr/bin/env bash
xdg-open http://localhost:6080/vnc.html >/dev/null 2>&1 || true
EOF
chmod +x "$HOME/Desktop/open-novnc.sh"

# Create a minimal desktop launcher helper for later game installation.
cat > "$HOME/Desktop/minecraft-launcher.sh" <<'EOF'
#!/usr/bin/env bash
# This is a placeholder for launching the actual Minecraft launcher later.
# Open the browser to the noVNC page first, then install the Minecraft Java launcher.
xdg-open http://localhost:6080/vnc.html >/dev/null 2>&1 || true
EOF
chmod +x "$HOME/Desktop/minecraft-launcher.sh"

# Install a Java-friendly Fabric tooling baseline for 1.21.1 and create a reusable workspace layout.
mkdir -p "$HOME/minecraft" "$HOME/minecraft/mods" "$HOME/minecraft/config" "$HOME/minecraft/worlds" "$HOME/minecraft/backups"

cat > "$HOME/minecraft/README.txt" <<'EOF'
Minecraft Java 1.21.1 + Fabric workspace
This folder is the working area inside the Codespace.
Use the desktop in noVNC to install the official Minecraft Launcher, Java 21, and Fabric Loader if needed.
EOF

cat > "$HOME/.bashrc" <<'EOF'
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"
export DISPLAY=:1
EOF

# Make Java available immediately in this shell.
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"

# Download the Fabric installer to the workspace as a baseline.
mkdir -p /tmp/minecraft-tools
curl -L "https://maven.fabricmc.net/net/fabricmc/fabric-installer/1.0.1/fabric-installer-1.0.1.jar" \
  -o /tmp/minecraft-tools/fabric-installer.jar

# Create a launcher helper script for later use.
cat > "$HOME/.local/bin/run-minecraft-desktop" <<'EOF'
#!/usr/bin/env bash
set -e
if [ ! -d "$HOME/.config/xfce4" ]; then
  mkdir -p "$HOME/.config/xfce4"
fi
if ! pgrep -x Xvfb >/dev/null; then
  Xvfb :1 -screen 0 1280x720x24 &
fi
if ! pgrep -x xfce4-session >/dev/null; then
  dbus-launch --exit-with-session startxfce4 &
fi
sleep 5
if ! pgrep -x x11vnc >/dev/null; then
  x11vnc -display :1 -listen 0.0.0.0 -nopw -xkb -noxdamage -rfbport 5901 -forever >/tmp/x11vnc.log 2>&1 &
fi
if ! pgrep -x websockify >/dev/null; then
  websockify --web /usr/share/novnc 6080 localhost:5901 >/tmp/novnc.log 2>&1 &
fi
printf '\nnoVNC is ready at: http://localhost:6080/vnc.html\n'
printf 'VNC is ready at: localhost:5901\n'
EOF
chmod +x "$HOME/.local/bin/run-minecraft-desktop"

printf '\nCodespace setup complete.\n'
printf 'Open the browser to http://localhost:6080/vnc.html to access the desktop.\n'
printf 'Then install the Minecraft Java launcher and Fabric inside the remote desktop.\n'
