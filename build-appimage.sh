#!/usr/bin/env bash
set -euo pipefail

docker run --rm \
  -e HOST_UID="$(id -u)" -e HOST_GID="$(id -g)" \
  -e APPIMAGE_EXTRACT_AND_RUN=1 \
  -v "$PWD":/src -w /src \
  ubuntu:20.04 bash -c '
    set -euo pipefail
    export DEBIAN_FRONTEND=noninteractive

    apt-get update
    apt-get install -y curl wget file build-essential pkg-config \
      libx11-dev libxtst-dev libxdo-dev libxkbcommon-dev libxcb1-dev libgl1-mesa-dev

    curl https://sh.rustup.rs -sSf | sh -s -- -y
    . "$HOME/.cargo/env"
    cargo build --release --target-dir target-appimage

    mkdir -p /tools
    cd /tools
    wget -q https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
    wget -q https://github.com/linuxdeploy/linuxdeploy-plugin-appimage/releases/download/continuous/linuxdeploy-plugin-appimage-x86_64.AppImage
    chmod +x *.AppImage
    export PATH=/tools:$PATH

    cd /src
    rm -rf AppDir
    linuxdeploy-x86_64.AppImage --appdir AppDir \
      --executable target-appimage/release/sharpclicks \
      --desktop-file sharpclicks.desktop \
      --icon-file icons/sharpclicks.png \
      --output appimage

    chown -R "$HOST_UID:$HOST_GID" AppDir target-appimage ./*.AppImage
  '