FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:1 \
    XDG_RUNTIME_DIR=/tmp

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        jq \
        unzip \
        wget \
        python3 \
        python3-pip \
        xauth \
        xorg \
        x11vnc \
        novnc \
        websockify \
        xfce4 \
        xfce4-goodies \
        openbox \
        dbus-x11 \
        xvfb \
        openjdk-21-jdk \
        mesa-utils \
        fonts-dejavu-core \
    && rm -rf /var/lib/apt/lists/*

# Install a simple browser if needed for later GUI work
RUN apt-get update \
    && apt-get install -y --no-install-recommends chromium-browser \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspaces
RUN mkdir -p /opt/novnc \
    && ln -sf /usr/share/novnc /opt/novnc/web \
    && ln -sf /usr/share/novnc/utils/launch.sh /usr/local/bin/novnc-launch

CMD ["/bin/bash"]
