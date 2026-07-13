#!/usr/bin/env ash

set -eu

: "${USER:?env USER is not set}"
: "${USER_UID:?env USER_UID is not set}"
: "${USER_GID:?env USER_GID is not set}"

DATA_DIR="/data"
USER_LINK="/home/${USER}/downloads"

ensure_owned_dir() {
    dir="$1"

    mkdir -p "${dir}"

    if [ "$(stat -c '%u:%g' "${dir}")" != "${USER_UID}:${USER_GID}" ]; then
        echo "Changing access rights for the ${dir} directory"
        chown -R "${USER_UID}:${USER_GID}" "${dir}"
    fi
}

ensure_owned_dir "${DATA_DIR}"
ensure_owned_dir "${DATA_DIR}/downloads"
ensure_owned_dir "${DATA_DIR}/log/firefox"
ensure_owned_dir "${DATA_DIR}/profile"

if [ ! -e "${USER_LINK}" ] && [ ! -L "${USER_LINK}" ]; then
    ln -s "${DATA_DIR}/downloads" "${USER_LINK}"
fi

if [ "${FF_OPEN_URL:-}" ]; then
  echo $FF_OPEN_URL > /tmp/open-url
fi
