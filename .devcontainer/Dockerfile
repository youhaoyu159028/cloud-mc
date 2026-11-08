FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:1 \
    XDG_RUNTIME_DIR=/tmp

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dbus-x11 \
        fonts-dejavu-core \
        git \
        openjdk-21-jre \
        mesa-utils \
        novnc \
        python3 \
        websockify \
        wget \
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
