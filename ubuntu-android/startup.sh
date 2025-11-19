#!/bin/sh
set -xe

/usr/bin/Xvfb :1 -screen 0 1920x1080x24 -ac &

sleep 2

/usr/bin/startxfce4 &

sleep 1

/usr/bin/x11vnc -display :1 -xkb -noxrecord -noxfixes  -ncache -noxdamage -forever -nopw &

sleep 1
/usr/share/novnc/utils/novnc_proxy &


cd /root
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmd-tools.zip
unzip cmd-tools.zip 

mkdir -p /root/Android/cmdline-tools
export ANDROID_SDK_ROOT=$HOME/Android
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
export PATH=$ANDROID_SDK_ROOT/emulator:$PATH

adb start-server &

mv cmdline-tools/ /root/Android/cmdline-tools/latest
yes | sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0"
sdkmanager "emulator"
sdkmanager "system-images;android-35;default;x86_64"

echo "no"  | avdmanager create avd -n pixel -k "system-images;android-35;default;x86_64"

emulator -avd pixel -gpu swiftshader_indirect -no-accel -no-boot-anim &

wait
