#!/usr/bin/env ash
URL_FILE="/tmp/open-url"
DATA_DIR="/data"

set -- --profile ${DATA_DIR}/profile --setDefaultBrowser

if [ -s "${URL_FILE}" ]; then
    read -r URL < "${URL_FILE}"
    set -- "$@" "${URL}"
fi

exec firefox "$@" >> ${DATA_DIR}/log/firefox/output.log 2>> ${DATA_DIR}/log/firefox/error.log
