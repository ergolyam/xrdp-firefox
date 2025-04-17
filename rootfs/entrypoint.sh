#!/usr/bin/env ash

set -eu

: "${USER:?env USER is not set}"

mkdir -p /config/downloads
mkdir -p /config/log/firefox
mkdir -p /config/profile

chown -R $USER:$USER /config

if [ "${FF_OPEN_URL:-}" ]; then
  echo $FF_OPEN_URL > /tmp/open-url
fi
