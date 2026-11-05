# FlClash Docker Guide

[简体中文](README_zh_CN.md)

The Docker image uses [LinuxServer Selkies](https://github.com/linuxserver/docker-baseimage-selkies)
to run the Linux version of FlClash as a single-app session and stream it to a
browser. It no longer loads a complete XFCE desktop, and it is not a headless
Clash API container.

Images are published for `linux/amd64` and `linux/arm64` at
`ghcr.io/pickrui/flclash`. Each stable release publishes both `latest` and a
version tag without the leading `v`, such as `0.8.93`.

The image contains no virtual machine and does not start a nested Docker daemon.
On Linux Docker Engine, FlClash, Labwc, and Selkies are ordinary Linux processes
inside the container. Docker Desktop on macOS and Windows runs one shared Linux
VM for all Linux containers; a VM process shown by the host belongs to Docker
Desktop, not to an extra VM bundled with FlClash.

FlClash is a graphical client, so an active browser session still requires
compositing and video encoding. It will use more resources than a headless
Clash/Mihomo container. The image defaults to 30 FPS with CSS scaling and
disables audio, microphone, gamepad, second-screen, and nested-Docker features.

The image includes the complete GNOME Keyring Secret Service and creates a
dedicated session D-Bus before FlClash starts. Secure credentials such as the
oixCloud token are stored under `/config/.local/share/keyrings` and are
automatically unlocked from the same persistent volume after a recreation.

## Requirements

- A Linux host with Docker Engine. Docker Compose v2 is recommended. Docker
  Desktop can run the image, but its Linux VM adds overhead and the TUN device
  mapping in this guide is specific to Linux hosts.
- At least 1 GB of shared memory for the browser desktop.
- `/dev/net/tun` and the `NET_ADMIN` capability only when FlClash TUN mode is
  required.

Check TUN support on the host before enabling it:

```bash
test -c /dev/net/tun && echo "TUN is available"
```

If the device is missing on a regular Linux distribution, load the module with
`sudo modprobe tun`. NAS systems may require TUN to be enabled in their own
administration interface.

## Quick Start With Docker Compose

Run the following commands from the repository root:

```bash
docker compose -f docker/docker-compose.yml pull
docker compose -f docker/docker-compose.yml up -d
docker compose -f docker/docker-compose.yml logs -f
```

Open `https://<host>:3001` after the container has started. Selkies uses a
self-signed certificate by default, so a browser certificate warning is
expected on first access.

Port `3000` provides plain HTTP and is intended for use behind a reverse proxy.
Use HTTPS on port `3001` for direct access because browser audio, video, and
clipboard features may not work over an insecure connection.

## Quick Start With Docker CLI

```bash
docker run -d \
  --name flclash \
  --restart unless-stopped \
  -e PUID="$(id -u)" \
  -e PGID="$(id -g)" \
  -e TZ=Asia/Shanghai \
  -p 3000:3000 \
  -p 3001:3001 \
  --cap-add NET_ADMIN \
  --device /dev/net/tun:/dev/net/tun \
  -v flclash-config:/config \
  --shm-size 1g \
  ghcr.io/pickrui/flclash:latest
```

Remove `--cap-add NET_ADMIN` and `--device /dev/net/tun:/dev/net/tun` when TUN
mode is not needed.

## Configuration

| Option | Purpose |
| --- | --- |
| `PUID` / `PGID` | User and group IDs used for files under `/config`; obtain them with `id` |
| `TZ` | Container time zone, for example `Asia/Shanghai` or `Etc/UTC` |
| `CUSTOM_USER` / `PASSWORD` | Optional basic authentication for trusted local networks |
| `3000/tcp` | Browser interface over HTTP; use behind a reverse proxy |
| `3001/tcp` | Browser interface over HTTPS with a self-signed certificate |
| `7890/tcp` | Default mixed proxy port; exposed only inside Docker networks unless explicitly published |
| `/config` | Persistent Selkies home directory and FlClash data |
| `/dev/net/tun` + `NET_ADMIN` | TUN device access; optional when TUN mode is unused |
| `shm_size: 1gb` | Shared memory recommended for the desktop session |
| `SELKIES_FRAMERATE` | Stream frame-rate limit; defaults to `30` in this image |
| `SELKIES_USE_CSS_SCALING` | Render at a lower resolution and scale in the browser; defaults to `true` |
| `/dev/dri` | Optional Intel/AMD render and encode device on Linux hosts |

The supplied Compose file uses the named volume `flclash-config`. To use a host
directory instead, replace its volume mapping with:

```yaml
volumes:
  - /absolute/path/to/flclash-config:/config
```

Ensure that the directory is writable by the configured `PUID` and `PGID`.

## Access Security

The browser interface has no authentication by default, and its terminal provides
passwordless `sudo` inside the container. Do not publish ports `3000` or `3001`
directly to the Internet.

For access on a trusted local network, basic authentication can be enabled by
adding these variables to the Compose service and recreating the container:

```yaml
environment:
  - CUSTOM_USER=flclash
  - PASSWORD=replace-with-a-strong-password
```

Basic authentication is not sufficient for public exposure. For remote access,
bind the Selkies port to the loopback interface and place it behind a reverse
proxy with HTTPS and robust authentication:

```yaml
ports:
  - "127.0.0.1:3001:3001"
```

The reverse proxy must connect to the HTTPS upstream on port `3001` and allow
its self-signed certificate, or connect to the HTTP upstream on port `3000`
without exposing that port publicly.

## Traffic Scope

FlClash runs inside the container. Enabling system proxy or TUN mode affects the
container; it does not automatically route traffic from the Docker host
or other LAN devices.

In the Docker image, runtime configuration forces `allow-lan` on and sets
`bind-address: '*'`. Other containers on the same Docker network can therefore
use `http://flclash:7890` or `socks5://flclash:7890` directly without publishing
the port on the host.

To make the proxy available only to the Docker host, bind it to host loopback:

```yaml
ports:
  - "127.0.0.1:7890:7890"
```

For LAN clients, replace `127.0.0.1` with a specific host LAN address and
restrict sources with the host firewall. Do not use an unqualified
`7890:7890`, which publishes the unauthenticated proxy on every host interface.

## Reducing CPU Usage

First distinguish container load from Docker Desktop VM overhead:

```bash
docker stats flclash
docker top flclash
```

Docker reports `100%` when one logical CPU is fully occupied. While the browser
page is open, Selkies must process screen changes. Close the page when the UI is
not needed; FlClash and its proxy core continue running, but the container no
longer encodes a video stream for that page.

Low-power hosts can reduce the frame rate to 20 or 15 FPS:

```yaml
environment:
  - SELKIES_FRAMERATE=20
```

Do not force a `linux/amd64` image on an ARM64 host, or the reverse. Compose
selects the native architecture automatically. A mismatched `--platform` uses
QEMU emulation and can increase CPU usage substantially.

On a Linux host with an Intel or AMD GPU, expose its render device:

```yaml
devices:
  - /dev/net/tun:/dev/net/tun
  - /dev/dri:/dev/dri
environment:
  - PIXELFLUX_WAYLAND=true
```

Selkies automatically selects the first available render node and attempts to
use the same device for rendering and encoding, avoiding CPU readback. Keep Full
Color 4:4:4 disabled on Intel and AMD because it may fall back to CPU encoding.
NVIDIA hosts require additional driver and container-runtime setup; consult the
upstream Selkies GPU documentation.

`cpus` or `--cpus` only caps peaks; it does not reduce the work being performed,
and a low limit makes the interface stutter. If most host load on macOS or
Windows comes from the Docker Desktop Linux VM, the image cannot remove that
fixed layer. A native Linux host is more efficient for continuous operation.

## Updating

The `/config` volume keeps application data when the container is recreated.
Update a Compose deployment with:

```bash
docker compose -f docker/docker-compose.yml pull
docker compose -f docker/docker-compose.yml up -d
```

On every start, the image synchronizes the current FlClash launcher into the
persistent volume. Stale Labwc, Openbox, or desktop autostart files left by the
old XFCE/Webtop image therefore cannot prevent FlClash from starting after an
upgrade. The keyring and application data remain intact.

Use `ghcr.io/pickrui/flclash:<version>` instead of `latest` in the Compose file
to pin a release. Version tags do not include the leading `v`.

## Troubleshooting

Inspect container status and logs first:

```bash
docker compose -f docker/docker-compose.yml ps
docker compose -f docker/docker-compose.yml logs --tail=200 flclash
```

- **The browser cannot connect:** confirm that the container is running and use
  `https://<host>:3001`. Accept the self-signed certificate warning for trusted
  local access.
- **TUN mode reports a permission or device error:** verify that
  `/dev/net/tun` exists and that both `NET_ADMIN` and the device mapping are
  present.
- **The browser interface is blank or the application exits immediately:** older kernels
  or libseccomp versions may require `security_opt: [seccomp:unconfined]`. This
  disables an important Docker security layer, so use it only when the default
  profile is confirmed to be the cause.
- **Files under `/config` are not writable:** set `PUID` and `PGID` to the owner
  of the host directory, then recreate the container.
- **oixCloud asks for login after recreation:** make sure `/config` is a
  persistent volume and `/config/.local/share/keyrings` is writable by the
  configured `PUID`. Do not mount only an individual configuration file.
- **CPU usage is high:** close unused browser sessions first, then lower the
  frame rate or configure GPU acceleration as described above. Docker Desktop
  users should also distinguish VM overhead from container usage.
- **Another container cannot reach the proxy:** put both containers on the same
  Docker network and use the `flclash` container name instead of `127.0.0.1`.
  For host access, publish port `7890` as described in the traffic scope section.

## Building Locally

Choose a FlClash release that contains the matching Linux `.deb` asset, then run
from the repository root:

```bash
docker buildx build --load \
  --platform linux/amd64 \
  --build-arg FLCLASH_VERSION=0.8.93 \
  -t flclash:local \
  docker
```

Use `--platform linux/arm64` for an ARM64 image. BuildKit supplies the matching
`TARGETARCH` value used by the Dockerfile.