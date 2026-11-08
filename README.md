# cloud-mc

这是一个**仅使用 GitHub Codespaces** 的实验项目：在 Codespace 中用 VS Code 插件 **Minecraft Workbench** 启动 Minecraft Java 版，再通过 **noVNC** 在浏览器里查看游戏画面。仓库不使用 GitHub Actions。

## 工作原理

1. Codespaces 创建 Linux 开发容器，并安装 Java 21、虚拟显示和 XFCE 桌面所需组件。
2. VS Code 安装 `Lopleec.minecraft-workbench` 插件；插件在 Codespace 远端启动 Minecraft 游戏进程。
3. Xvfb 提供虚拟显示 `:1`，Minecraft Workbench 的游戏窗口使用该显示。
4. x11vnc 和 noVNC 将桌面画面通过 Codespaces 的私有转发端口 6080 显示在浏览器中。

**启动器是 Minecraft Workbench 插件**，不是另外安装的 Minecraft Launcher。插件文档说明，在容器/远程环境启动游戏需要图形会话；此配置就是给游戏进程提供虚拟图形会话。

## 开始游玩

1. 打开本仓库，在 GitHub 上创建 Codespace，等待开发容器完成构建。
2. 在 Codespaces 的 **端口（Ports）** 面板中找到端口 **6080**，选择 **在浏览器中打开**。页面使用 `/vnc.html`；如果显示目录页，可在转发网址后加上 `/vnc.html`。
3. 回到 Codespaces 的 VS Code 窗口，点击活动栏里的 **Minecraft** 插件。
4. 首次使用时按插件提示阅读并确认协议；然后进入 **实例 → 新建实例**。
5. 游戏版本选 **1.21.1**，加载器选 **Fabric**。按插件界面添加你有权使用的账户，并选择 **安装 / 修复**。
6. 安装完成后点击 **启动（Launch）**。游戏窗口应显示在 noVNC 浏览器页面的远程桌面中。

端口 6080 配置为 **Private（私有）**。不要把它改成 Public，也不要公开分享 Codespaces 的转发链接。

## 世界存档

- 通过 Minecraft Workbench 的**世界存档备份/导出**功能保存重要世界，并将导出的备份放进 Codespace 工作区中的私有备份目录。
- Codespace 正常停止后，环境中的文件通常会保留；但删除 Codespace、重建容器或遇到意外情况时，不应把它当作唯一备份。
- 这是公开仓库：不要把世界存档、账号凭据、令牌或个人配置提交到 Git。`.gitignore` 已忽略 Minecraft 存档和本地游戏数据。
- 游戏运行时进程会在 Codespace 停止或休眠时结束。恢复 Codespace 后需要重新打开桌面并从插件启动实例。

## 限制与排错

- 这是实验性桌面转发，不是有 GPU 的云游戏主机。配置使用 Mesa 软件渲染；帧率可能很低，游戏也可能因 Codespaces 资源限制或图形兼容性而无法启动。
- 如果 noVNC 页面打不开，请检查 Codespaces 的端口面板中 6080 是否已转发，以及容器启动日志：`/tmp/cloud-mc-xvfb.log`、`/tmp/cloud-mc-vnc.log`、`/tmp/cloud-mc-novnc.log`。
- 如果桌面能打开但游戏没有画面，检查 Minecraft Workbench 的输出/任务日志，以及 Codespace 终端中的 `/tmp/cloud-mc-xfce.log`。确认插件运行在 Codespace 远端，并且游戏进程继承了 `DISPLAY=:1`。
- 若游戏提示 OpenGL 不支持或进程崩溃，说明当前 Codespaces 环境可能无法满足 Minecraft 客户端的图形要求；noVNC 只能转发画面，不能补出 GPU 能力。
