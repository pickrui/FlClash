FROM lscr.io/linuxserver/webtop:debian-xfce

ARG FLCLASH_VERSION
ARG FLCLASH_REPO=pickrui/FlClash
ARG TARGETARCH

ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN:zh \
    LC_ALL=zh_CN.UTF-8 \
    TZ=Asia/Shanghai

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      wget \
      tzdata \
      locales \
      fonts-noto-cjk \
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

RUN mkdir -p /config/.config/autostart
COPY flclash-autostart.desktop /config/.config/autostart/flclash-autostart.desktop
