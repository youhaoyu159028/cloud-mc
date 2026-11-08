FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:1 \
    XDG_RUNTIME_DIR=/tmp \
    LIBGL_ALWAYS_SOFTWARE=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dbus-x11 \
        fonts-dejavu-core \
        git \
        libasound2t64 \
        libgl1 \
        libgl1-mesa-dri \
        libxcursor1 \
        libxinerama1 \
        libxrandr2 \
        libxrender1 \
        libxtst6 \
        mesa-utils \
        novnc \
        openjdk-21-jre \
        python3 \
        websockify \
        x11-utils \
        x11vnc \
        xauth \
        xfce4 \
        xfce4-goodies \
        xorg \
        xvfb \
        unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspaces
CMD ["/bin/bash"]
