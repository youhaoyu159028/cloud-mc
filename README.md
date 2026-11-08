# cloud-mc

A GitHub Codespaces experiment for playing Minecraft Java Edition through the **Minecraft Workbench VS Code extension** and a browser-accessible **noVNC** desktop. This repository does not use GitHub Actions.

## How the display path works

1. VS Code installs `Lopleec.minecraft-workbench` into the Codespace.
2. Minecraft Workbench launches the Minecraft game process on the Codespace's graphical display (`DISPLAY=:1`).
3. Xvfb provides that display, XFCE provides a desktop, and noVNC streams the display to your browser through forwarded port 6080.

The extension is the launcher; no separate Minecraft launcher is installed by this devcontainer. The first run may require accepting the extension notices, choosing **Instances → New instance**, selecting **Minecraft 1.21.1** and **Fabric**, setting up an account, then choosing **Install / Repair** and **Launch**. Use an account and authentication method you are authorized to use. The extension's documentation says remote/container launches require a graphical session; this devcontainer provides a virtual one.

## Start playing

1. Open this repository in a GitHub Codespace and let the devcontainer build.
2. In the Codespace, open the **Ports** tab and open port **6080** in the browser. The URL should end with `/vnc.html` (or add that path).
3. In the Codespaces VS Code window, open **Minecraft** in the Activity Bar.
4. Create an instance with game version **1.21.1** and loader **Fabric**.
5. Install/repair the instance, then launch it. The game window should appear in the noVNC browser tab.

If the game window does not appear, check the Workbench output/logs and the Codespace terminal for `/tmp/cloud-mc-*.log`. Keep the Codespace port visibility **Private**; the raw VNC port is not forwarded.

## Saves and limitations

- Codespaces is experimental for gameplay: it has no guaranteed gaming GPU, so rendering can be slow or fail. This setup uses software rendering.
- Stopping/suspending the Codespace stops the game process. Files in the Codespace workspace normally remain available when it resumes, but a rebuild or deletion can remove data outside the repository.
- Keep important worlds in a workspace-backed location and make separate backups. Do not commit worlds to this public repository; `.gitignore` excludes local game data.
- This is not a permanent cloud PC or a guarantee of smooth gameplay.
