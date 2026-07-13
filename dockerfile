FROM ghcr.io/ergolyam/xrdp-docker:alpine-3.24

RUN apk add --no-cache \
       ttf-dejavu \
       firefox \
       pcmanfm

COPY rootfs /

