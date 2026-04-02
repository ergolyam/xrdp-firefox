#!/usr/bin/env ash

set -eu

: "${USER:?env USER is not set}"

mkdir -p /config/downloads

TARGET="/config/downloads"
LINK="/home/$USER/downloads"

if [ ! -e "$LINK" ] && [ ! -L "$LINK" ]; then
    ln -s "$TARGET" "$LINK"
fi

mkdir -p /config/log/firefox
mkdir -p /config/profile

chown -R $USER:$USER /config
ln -s /home/$USER/downloads

if [ "${FF_OPEN_URL:-}" ]; then
  echo $FF_OPEN_URL > /tmp/open-url
fi
