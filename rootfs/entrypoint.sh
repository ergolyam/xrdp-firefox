#!/usr/bin/env ash

set -eu

: "${USER:?env USER is not set}"

DATA_DIR="/data"
USER_LINK="/home/$USER/downloads"

mkdir -p ${DATA_DIR}/downloads
mkdir -p ${DATA_DIR}/log/firefox
mkdir -p ${DATA_DIR}/profile

if [ ! -e "${USER_LINK}" ] && [ ! -L "${USER_LINK}" ]; then
    ln -s "${DATA_DIR}/downloads" "${USER_LINK}"
fi

chown -R $USER:$USER ${DATA_DIR}

if [ "${FF_OPEN_URL:-}" ]; then
  echo $FF_OPEN_URL > /tmp/open-url
fi
