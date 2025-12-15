FROM debian:bookworm-slim

ENV DISPLAY=:1
ENV LIBGL_ALWAYS_SOFTWARE=1 \
 GALLIUM_DRIVER=llvmpipe \
 LIBGL_DRI3_DISABLE=1 \
 LIBGL_DRI2_DISABLE=1

RUN apt-get update && \
 apt-get install -y --no-install-recommends \
    xvfb \
    openbox \
    sudo \
    lxterminal \
    dbus-x11 \
    x11vnc \
    novnc \
    python3-xdg \
    websockify \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libegl1-mesa \
    mesa-utils \
    android-tools-adb \
    wget \
    unzip \
    openjdk-17-jdk \
    libpulse-dev \
 && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

RUN useradd -m debusr && adduser debusr sudo \
&& echo "debusr ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/debusr
COPY startup.sh /home/debusr/startup.sh

RUN mkdir -p /home/debusr/Android/cmdline-tools
# https://developer.android.com/studio#command-line-tools-only
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip -O cmd-tools.zip \
 && unzip cmd-tools.zip 

RUN chown -R debusr:debusr /home/debusr
USER debusr

EXPOSE 6080

CMD /bin/bash /home/debusr/startup.sh
