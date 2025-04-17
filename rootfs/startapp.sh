#!/usr/bin/env ash
URL_FILE=/tmp/open-url

set -- --profile /config/profile --setDefaultBrowser

if [ -s "$URL_FILE" ]; then
    read -r URL < "$URL_FILE"
    set -- "$@" "$URL"
fi

exec firefox "$@" >> /config/log/firefox/output.log 2>> /config/log/firefox/error.log
