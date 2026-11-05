FROM ghcr.io/linuxserver/baseimage-selkies:debiantrixie

ARG FLCLASH_VERSION
ARG FLCLASH_REPO=pickrui/FlClash
ARG TARGETARCH

ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN:zh \
    LC_ALL=zh_CN.UTF-8 \
  TZ=Asia/Shanghai \
  TITLE=FlClash \
  FLCLASH_DOCKER=true \
  SELKIES_UI_TITLE=FlClash \
  START_DOCKER=false \
  NO_GAMEPAD=true \
  PIXELFLUX_WAYLAND=true \
  SELKIES_FRAMERATE=30 \
  SELKIES_USE_CSS_SCALING=true \
  SELKIES_SECOND_SCREEN=false \
  SELKIES_AUDIO_ENABLED=false \
  SELKIES_MICROPHONE_ENABLED=false \
  SELKIES_GAMEPAD_ENABLED=false \
  SELKIES_ENABLE_SHARING=false

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      wget \
      tzdata \
      locales \
      fonts-noto-cjk \
      gnome-keyring \
      libsecret-1-0 \
      libgl1-mesa-dri \
      libglx-mesa0 && \
    sed -i '/zh_CN.UTF-8 UTF-8/s/^# //' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=zh_CN.UTF-8 && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    wget -O /tmp/flclash.deb \
      "https://github.com/${FLCLASH_REPO}/releases/download/v${FLCLASH_VERSION}/flclash-linux-${TARGETARCH}.deb" && \
    apt-get install -y --no-install-recommends /tmp/flclash.deb && \
    rm -f /tmp/flclash.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --chmod=755 root/defaults/autostart /defaults/autostart
COPY --chmod=755 root/defaults/autostart /defaults/autostart_wayland
COPY --chmod=755 root/custom-cont-init.d/10-flclash-config /custom-cont-init.d/10-flclash-config

EXPOSE 7890
