# cloud-mc

This repository is set up to work as a GitHub Codespaces experiment for a Minecraft Java 1.21.1 + Fabric workspace using VS Code and a browser-based noVNC desktop.

Important note:
- This is not a dedicated cloud gaming VM.
- GitHub Codespaces is a remote container, not a full GPU-backed gaming host.
- Minecraft Java client launching is experimental and may be unstable or unusable in this environment.
- The goal is to provide a remote desktop environment with Java tooling and browser access to the desktop.

What this repo includes:
- VS Code devcontainer config
- Linux desktop environment
- VNC + noVNC browser access
- Java 21 and Fabric baseline tooling
- Minecraft workspace folders for mods, config, and backups

How to use:
1. Open this repo in GitHub Codespaces.
2. Wait for the devcontainer to finish building.
3. In the forwarded ports, open port 6080.
4. Visit http://localhost:6080/vnc.html
5. Use the browser to access the desktop inside the Codespace.
6. Install the Minecraft Java launcher, Fabric, and your modpack inside that desktop.
7. Keep world backups in the `minecraft/worlds` folder.

Files in this repo:
- `.devcontainer/devcontainer.json`
- `.devcontainer/Dockerfile`
- `.devcontainer/setup.sh`
- `.devcontainer/start-vnc.sh`

Known limitations:
- Minecraft Java client may not open properly without a real desktop GPU and hardware acceleration.
- Codespaces sessions can suspend and stop running apps.
- Keep your world saves backed up regularly.
