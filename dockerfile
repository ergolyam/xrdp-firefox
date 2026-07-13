FROM ghcr.io/ergolyam/xrdp-docker:alpine-3.23

RUN apk add --no-cache \
       ttf-dejavu \
       firefox \
       pcmanfm

COPY rootfs /

