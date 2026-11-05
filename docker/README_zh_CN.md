# FlClash Docker 使用指南

[English](README.md)

Docker 镜像基于 [LinuxServer Selkies](https://github.com/linuxserver/docker-baseimage-selkies)
以单应用会话运行 Linux 版 FlClash，并将应用画面串流到浏览器。它不再加载完整的
XFCE 桌面，也不是无界面的 Clash API 容器。

镜像发布在 `ghcr.io/pickrui/flclash`，支持 `linux/amd64` 和
`linux/arm64`。每个稳定版本会同时发布 `latest` 和不带前导 `v` 的版本标签，
例如 `0.8.93`。

镜像中没有虚拟机，也不会启动嵌套 Docker daemon。在 Linux Docker Engine 上，
FlClash、Labwc 和 Selkies 都是容器中的普通 Linux 进程。macOS 和 Windows 上的
Docker Desktop 会为所有 Linux 容器运行一个共享的 Linux 虚拟机；宿主机显示的
虚拟机进程属于 Docker Desktop，不是 FlClash 镜像额外内置的虚拟机。

FlClash 是图形客户端，浏览器连接时仍需合成并编码应用画面，因此资源占用会高于
纯命令行的 Clash/Mihomo 容器。镜像默认将串流限制为 30 FPS、启用 CSS 缩放，并
关闭音频、麦克风、手柄、第二屏和嵌套 Docker，以降低 CPU 与内存开销。

镜像包含完整的 GNOME Keyring Secret Service，并在 FlClash 启动前创建独立的
会话 D-Bus。oixCloud 等安全凭据保存在 `/config/.local/share/keyrings`，容器更新
或重建后会从同一持久卷自动解锁

## 运行要求

- Linux 宿主机和 Docker Engine，推荐使用 Docker Compose v2。Docker Desktop
  也能运行镜像，但其 Linux 虚拟机有额外资源开销，且本文的 TUN 设备映射仅适用于
  Linux 宿主机。
- 为浏览器桌面分配至少 1 GB 共享内存。
- 仅在使用 FlClash TUN 模式时需要 `/dev/net/tun` 和 `NET_ADMIN` 权限。

启用 TUN 前先检查宿主机：

```bash
test -c /dev/net/tun && echo "TUN is available"
```

普通 Linux 发行版缺少该设备时，可运行 `sudo modprobe tun` 加载模块。NAS
系统可能需要在管理界面中单独启用 TUN。

## 使用 Docker Compose

在仓库根目录运行：

```bash
docker compose -f docker/docker-compose.yml pull
docker compose -f docker/docker-compose.yml up -d
docker compose -f docker/docker-compose.yml logs -f
```

容器启动后访问 `https://<宿主机地址>:3001`。Selkies 默认使用自签名证书，
首次访问时出现浏览器证书警告属于正常现象。

端口 `3000` 提供纯 HTTP，适合在反向代理后使用。直接访问时应使用 `3001`
端口的 HTTPS，否则浏览器的音频、视频和剪贴板等功能可能无法正常工作。

## 使用 Docker CLI

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

不使用 TUN 模式时，可以移除 `--cap-add NET_ADMIN` 和
`--device /dev/net/tun:/dev/net/tun`。

## 配置说明

| 配置 | 用途 |
| --- | --- |
| `PUID` / `PGID` | `/config` 文件所用的用户和组 ID，可通过 `id` 查询 |
| `TZ` | 容器时区，例如 `Asia/Shanghai` 或 `Etc/UTC` |
| `CUSTOM_USER` / `PASSWORD` | 可选的基础身份验证，仅适合可信局域网 |
| `3000/tcp` | 浏览器界面的 HTTP 入口，应放在反向代理后使用 |
| `3001/tcp` | 浏览器界面的 HTTPS 入口，默认使用自签名证书 |
| `7890/tcp` | 默认混合代理端口，仅在 Docker 网络内声明，不会自动发布到宿主机 |
| `/config` | 持久化 Selkies 用户目录和 FlClash 数据 |
| `/dev/net/tun` + `NET_ADMIN` | TUN 设备访问权限，不使用 TUN 时可移除 |
| `shm_size: 1gb` | 桌面会话所需的共享内存大小 |
| `SELKIES_FRAMERATE` | 串流帧率上限，镜像默认为 `30` |
| `SELKIES_USE_CSS_SCALING` | 使用较低渲染分辨率后由浏览器缩放，镜像默认为 `true` |
| `/dev/dri` | 可选的 Intel/AMD GPU 渲染与编码设备，仅适用于 Linux 宿主机 |

仓库自带的 Compose 文件使用命名卷 `flclash-config`。如需将数据直接保存到
宿主机目录，可将卷映射替换为：

```yaml
volumes:
  - /absolute/path/to/flclash-config:/config
```

请确保该目录可由 `PUID` 和 `PGID` 对应的用户写入。

## 访问安全

浏览器界面默认没有身份验证，并且其中的终端可以在容器内免密码使用 `sudo`。
不要将 `3000` 或 `3001` 端口直接暴露到公网。

在可信局域网内使用时，可以将以下变量加入 Compose 服务并重建容器，从而启用
基础身份验证：

```yaml
environment:
  - CUSTOM_USER=flclash
  - PASSWORD=请替换为高强度密码
```

基础身份验证不足以保护公网入口。远程访问时，应仅将 Selkies 端口绑定到本机，
再通过带有 HTTPS 和可靠身份验证的反向代理提供服务：

```yaml
ports:
  - "127.0.0.1:3001:3001"
```

反向代理可以连接 `3001` 端口的 HTTPS 上游并允许其自签名证书，也可以连接
`3000` 端口的 HTTP 上游，但不得将该 HTTP 端口直接公开。

## 流量作用范围

FlClash 运行在容器网络命名空间中。启用系统代理或 TUN 模式只会影响该容器，
不会自动接管 Docker 宿主机或其他局域网设备的流量。

Docker 镜像会在运行时为代理监听强制启用 `allow-lan` 并设置
`bind-address: '*'`，因此同一 Docker 网络中的其他容器可以直接使用
`http://flclash:7890` 或 `socks5://flclash:7890`。无需将该端口发布到宿主机

如需让宿主机使用代理，可仅绑定宿主机回环地址：

```yaml
ports:
  - "127.0.0.1:7890:7890"
```

如需让局域网设备使用，应将 `127.0.0.1` 换成指定的宿主机局域网地址，并通过
防火墙限制来源。切勿使用无主机地址的 `7890:7890` 将无身份验证代理暴露到所有
宿主机接口或公网

## 降低 CPU 占用

先确认是容器本身还是 Docker Desktop 的虚拟机在占用 CPU：

```bash
docker stats flclash
docker top flclash
```

Docker 的 `100%` 表示占满一个逻辑 CPU。浏览器页面打开时，Selkies 需要持续处理
画面变化；不需要操作界面时关闭页面，FlClash 和代理核心会继续在容器中运行，
但不再为该页面编码视频流。

低性能设备可以将帧率继续降到 20 或 15 FPS：

```yaml
environment:
  - SELKIES_FRAMERATE=20
```

不要在 ARM64 宿主机上强制使用 `linux/amd64` 镜像，反之亦然。Compose 默认会
自动选择本机架构；强制错误架构会通过 QEMU 模拟运行并显著增加 CPU 占用。

Linux 宿主机配有 Intel 或 AMD GPU 时，可以将渲染设备映射进容器：

```yaml
devices:
  - /dev/net/tun:/dev/net/tun
  - /dev/dri:/dev/dri
environment:
  - PIXELFLUX_WAYLAND=true
```

Selkies 会自动选择首个可用的渲染节点，并尽量使用同一设备完成渲染和编码，避免
CPU 回读。启用 GPU 后仍应保持 Full Color 4:4:4 关闭；Intel/AMD 设备启用该模式
可能回退到 CPU 编码。NVIDIA 主机需要额外配置驱动和容器运行时，请参阅 Selkies
上游 GPU 文档。

`cpus` 或 `--cpus` 只能限制峰值，不能减少实际工作量；限制过低会造成界面卡顿。
macOS 或 Windows 若主要开销来自 Docker Desktop 的 Linux 虚拟机，镜像无法消除
这层固定成本，长期运行时使用原生 Linux 宿主机会更省资源。

## 更新镜像

重建容器时，`/config` 卷中的应用数据会保留。Compose 部署可通过以下命令更新：

```bash
docker compose -f docker/docker-compose.yml pull
docker compose -f docker/docker-compose.yml up -d
```

新版镜像每次启动都会把当前 FlClash 启动入口同步到持久卷，因此从旧 XFCE/Webtop
镜像升级时，卷中残留的旧 Labwc、Openbox 或桌面自动启动文件不会阻止应用启动。
keyring 与 FlClash 数据仍会保留

如需固定版本，将 Compose 文件中的镜像改为
`ghcr.io/pickrui/flclash:<版本号>`。版本标签不包含前导 `v`。

## 常见问题

首先检查容器状态和日志：

```bash
docker compose -f docker/docker-compose.yml ps
docker compose -f docker/docker-compose.yml logs --tail=200 flclash
```

- **浏览器无法连接：** 确认容器正在运行，并访问
  `https://<宿主机地址>:3001`。在可信局域网中可接受自签名证书警告。
- **TUN 模式提示权限或设备错误：** 确认 `/dev/net/tun` 存在，并同时配置
  `NET_ADMIN` 和设备映射。
- **浏览器界面空白或应用立即退出：** 较旧的内核或 libseccomp 版本可能需要添加
  `security_opt: [seccomp:unconfined]`。该配置会关闭 Docker 的重要安全层，
  仅应在确认默认 seccomp 配置导致问题时使用。
- **无法写入 `/config`：** 将 `PUID` 和 `PGID` 设为宿主机目录所有者的
  ID，然后重建容器。
- **oixCloud 重建后需要重新登录：** 确认 `/config` 使用持久卷，并检查
  `/config/.local/share/keyrings` 可由 `PUID` 对应用户写入。不要只挂载单个配置文件
- **CPU 占用高：** 先关闭未使用的浏览器页面，再按照“降低 CPU 占用”一节降低
  帧率或配置 GPU。Docker Desktop 用户还需在宿主机侧区分虚拟机开销。
- **其他容器无法连接代理：** 确认两个容器加入同一 Docker 网络，并使用容器名
  `flclash` 而不是 `127.0.0.1`。宿主机使用时按“流量作用范围”发布 `7890`

## 本地构建

选择一个包含对应 Linux `.deb` 文件的 FlClash 版本，然后在仓库根目录运行：

```bash
docker buildx build --load \
  --platform linux/amd64 \
  --build-arg FLCLASH_VERSION=0.8.93 \
  -t flclash:local \
  docker
```

构建 ARM64 镜像时使用 `--platform linux/arm64`。BuildKit 会为 Dockerfile
提供对应的 `TARGETARCH` 值。