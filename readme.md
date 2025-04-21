# xrdp-firefox
This project provides a **tiny image that boots straight into an XRDP + IceWM session** and then immediately launches **Firefox** in full‑screen mode.
Treat it as a ready‑made browser kiosk or use it as a base for your own GUI‑only container.

## Usage

- Pull image:
    ```bash
    docker pull ghcr.io/grisha765/xrdp-firefox:latest
    ```

- Run container:
    ```bash
    docker run -p 3389:3389 \
                -e USER=demo -e PASSWD=secret \
                -v $PWD/config:/config \
                ghcr.io/grisha765/xrdp-firefox:latest
    ```

- Run with ssl keys:
    ```bash
    openssl req -x509 -newkey rsa:2048 -nodes -keyout /path/to/key.pem -out /path/to/cert.pem -days 365
    ```
    ```bash
    docker run -p 3389:3389 \
                -e USER=demo -e PASSWD=secret \
                -v $PWD/config:/config \
                -v /path/to/key.pem:/key.pem:ro \
                -v /path/to/cert.pem:/cert.pem:ro \
                ghcr.io/grisha765/xrdp-firefox:latest
    ```

- Now connect to **`localhost:3389`** with any RDP client (username **demo**, password **secret**). You will land in a maximised Firefox window; when the last tab closes, the session ends and the container stops.

## Environment Variables

This image supports all base variables documented in [`xrdp-docker`](https://github.com/grisha765/xrdp-docker?tab=readme-ov-file#environment-variables).

In addition, the following environment variables are specific to **xrdp-firefox**:

| Variable         | Description |
|------------------|-------------|
| `FF_OPEN_URL`    | (Optional) URL to open on browser start. |
| `XKBMAP_OPTION`  | (Optional) XKB option string to configure keyboard layout switching (default: `grp:win_space_toggle`). |

## Features

- **No VNC hop**: uses `xrdp` + `xorgxrdp`; clients see a native RDP server on port 3389.
- **Persistent browser state**: mount `/config` to keep the Firefox profile, downloads and logs across runs.
- **IceWM kiosk mode**: no task‑bar, no start menu Firefox owns the entire screen.
- **Keyboard layout switcher**: `Super + Space` toggles between US and RU layouts.
- **PCManFM integration**: `inode/directory` is bound to PCManFM so file links in Firefox open a file‑manager window.
