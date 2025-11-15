#!/bin/sh
set -xe

/usr/bin/Xvfb :1 -screen 0 1920x1080x24 -ac &

sleep 2

/usr/bin/startxfce4 &

sleep 1

/usr/bin/x11vnc -display :1 -xkb -noxrecord -noxfixes  -ncache -noxdamage -forever -nopw &

sleep 1
/usr/share/novnc/utils/novnc_proxy &

wait
