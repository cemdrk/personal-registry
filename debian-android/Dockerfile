
FROM debian:bookworm-slim
# debian + openbox + novnc + android 35 emulator
ENV DEBIAN_FRONTEND=noninteractive \
 DISPLAY=:1 \
 KVM_ENABLED=false

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openbox \
    x11vnc \
    xvfb \
    dbus-x11 \
    novnc \
    websockify \
    sudo \
    android-tools-adb \
    lxterminal \
    wget unzip \
    openjdk-17-jdk \
    libpulse-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN  useradd -m debusr && adduser debusr sudo \
&& echo "debusr ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 

RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html
COPY startup.sh /home/debusr/startup.sh

RUN chown -R debusr:debusr /home/debusr
USER debusr
WORKDIR /home/debusr
RUN mkdir -p /home/debusr/Android/cmdline-tools
# https://developer.android.com/studio#command-line-tools-only
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip -O cmd-tools.zip \
 && unzip cmd-tools.zip 

EXPOSE 6080

CMD /bin/bash /home/debusr/startup.sh
