#!/bin/sh

set -xe

sudo /usr/bin/Xvfb :1 -screen 0 1920x1080x24 -ac &

sleep 2

sudo /usr/bin/startxfce4 &

sleep 1

sudo /usr/bin/x11vnc -display :1 -xkb -noxrecord -noxfixes -noxdamage -forever -nopw &

sleep 1
sudo /usr/bin/novnc_server --web /usr/share/novnc/ &

sleep 2

chromium \
  --no-first-run \
  --test-type \
  --no-sandbox \
  --start-maximized \
  --password-store=basic \
  --simulate-outdated-no-au='Tue, 31 Dec 2099 23:59:59' \
  --disable-dev-shm-usage \
  --user-data-dir=/home/vuser/userdata/ \
  &

wait
