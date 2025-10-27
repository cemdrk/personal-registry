FROM alpine:3.22

ENV DISPLAY=:1

RUN apk add --no-cache \
  xfce4 \
  xfce4-terminal \
  xvfb \
  x11vnc \
  novnc \
  chromium \
  sudo

RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

RUN adduser -D -s /bin/bash vuser && \
echo "vuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vuser && \
chmod 0440 /etc/sudoers.d/vuser

RUN mkdir -p /home/vuser/Desktop/userdata

COPY --chown=vuser:vuser startup.sh /home/vuser/startup.sh

RUN chmod +x /home/vuser/startup.sh

USER vuser

WORKDIR /home/vuser

ENTRYPOINT ["/home/vuser/startup.sh" ]
