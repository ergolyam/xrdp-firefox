FROM ghcr.io/grisha765/xrdp-docker:latest

RUN apk add --no-cache \
       ttf-dejavu \
       firefox \
       pcmanfm

COPY rootfs /

