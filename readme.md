# xrdp-firefox
This project provides a **tiny image that boots straight into an XRDP + IceWM session** and then immediately launches **Firefox** in a maximised window.
Treat it as a ready‑made browser kiosk built on top of [`xrdp-docker`](https://github.com/ergolyam/xrdp-docker) or use it as a base for your own GUI‑only container.

## Usage

- Pull image:
    ```bash
    docker pull ghcr.io/ergolyam/xrdp-firefox:latest
    ```

- Run container:
    ```bash
    docker run -p 3389:3389 \
                -e USER=demo -e PASSWD=secret \
                -v $PWD/data:/data \
                ghcr.io/ergolyam/xrdp-firefox:latest
    ```
    - Mounting `/data` is what keeps the Firefox profile, downloads and logs across restarts.

- Run with ssl keys:
    ```bash
    openssl req -x509 -newkey rsa:2048 -nodes -keyout /path/to/key.pem -out /path/to/cert.pem -days 365
    ```
    ```bash
    docker run -p 3389:3389 \
                -e USER=demo -e PASSWD=secret \
                -v $PWD/data:/data \
                -v /path/to/key.pem:/key.pem:ro \
                -v /path/to/cert.pem:/cert.pem:ro \
                ghcr.io/ergolyam/xrdp-firefox:latest
    ```

- Now connect to **`localhost:3389`** with any RDP client (username **demo**, password **secret**). You will land in a maximised Firefox window; when the Firefox process exits, the session ends and the container stops.

## Environment Variables

This image supports all base variables documented in [`xrdp-docker`](https://github.com/ergolyam/xrdp-docker?tab=readme-ov-file#environment-variables).

In addition, the following environment variables are specific to **xrdp-firefox**:

| Variable         | Description |
|------------------|-------------|
| `FF_OPEN_URL`    | (Optional) URL to open in the first Firefox window on browser start. |

When you mount `/data`, the container stores:

- Firefox profile in `/data/profile`
- downloaded files in `/data/downloads` (also linked into the user home directory as `~/downloads`)
- browser logs in `/data/log/firefox/output.log` and `/data/log/firefox/error.log`

## Features

- **No VNC hop**: uses `xrdp` + `xorgxrdp`; clients see a native RDP server on port 3389.
- **Persistent browser state**: mount `/data` to keep the Firefox profile, downloads and logs across runs.
- **IceWM kiosk mode**: no task‑bar, no start menu Firefox opens maximised and owns the screen.
- **Optional keyboard layout switcher**: set `XKBMAP_LAYOUT=ru`; by default `Super + Space` toggles between `us` and `ru`.
- **PCManFM integration**: `inode/directory` is bound to PCManFM so file links in Firefox open a file‑manager window.
