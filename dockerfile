FROM ghcr.io/ergolyam/xrdp-docker:alpine3.24

RUN apk add --no-cache \
       ttf-dejavu \
       firefox \
       pcmanfm

COPY rootfs /

