#!/bin/sh

# Default qBittorrent to listen on port 8080.
QBITTORRENT_PORT=${QBITTORRENT_PORT:-8080}

# Assume user wants to run qbittorrent as user/group with id 1000
# This can be changed by passing --user <uid>:<gid> to docker run
USER_ID=${USER_ID:-1000}
GROUP_ID=${GROUP_ID:-1000}

# Update user and group to provided ids
groupmod -o -g "$GROUP_ID" qbittorrent
usermod -o -u "$USER_ID" qbittorrent

# ensure config directory exists
mkdir -p /config/qBittorrent
chown -R qbittorrent:qbittorrent /config

# start qBittorrent
sudo -HEu qbittorrent qbittorrent-nox --webui-port=$QBITTORRENT_PORT
