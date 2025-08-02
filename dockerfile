FROM ghcr.io/ergolyam/xrdp-docker:latest

RUN apk add --no-cache \
       ttf-dejavu \
       firefox \
       pcmanfm

COPY rootfs /

