
FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

WORKDIR /root

RUN apt-get update && \
apt-get install -y --no-install-recommends \
    xfce4 \
    x11vnc \
    xvfb \
    dbus-x11 \
    novnc \
    websockify \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

COPY startup.sh /root/startup.sh
RUN touch /root/.Xauthority

EXPOSE 6080

CMD /bin/bash /root/startup.sh
