#!/bin/sh

set -xe

export ANDROID_SDK_ROOT=$HOME/Android
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
export PATH=$ANDROID_SDK_ROOT/emulator:$PATH

sudo Xvfb ${DISPLAY} -screen 0 1920x1080x24 -dpi 96 -ac +extension GLX &

sleep 2

openbox-session &

sleep 1

sudo x11vnc -display  ${DISPLAY} \
  -xkb -noxrecord -noxfixes -shared  -ncache -noxdamage -forever -nopw &

sleep 1
sudo /usr/share/novnc/utils/novnc_proxy &

cd /home/debusr
mv cmdline-tools/ /home/debusr/Android/cmdline-tools/latest
yes | sdkmanager --licenses
sdkmanager \
    "platform-tools" \
    "platforms;android-35" \
    "build-tools;35.0.0" \
    "emulator" \
    "system-images;android-35;google_apis;x86_64" 

adb start-server &

echo "no" | avdmanager create avd \
  -n "pixel35" \
  -k "system-images;android-35;google_apis;x86_64" \
  --device "pixel"

if [[ "$KVM_ENABLED" == true ]]; then
    echo "KVM Enabled"
    sudo chown debusr /dev/kvm
    emulator -avd pixel35 -window-size 1080x1920 \
    -read-only -no-skin -dpi-device 96 \
     -no-metrics -no-snapshot-save -no-snapshot-load -delay-adb  -no-snapshot -no-audio \
     -camera-back none -camera-front none -no-boot-anim -gpu swiftshader_indirect &
else
   echo "KVM Not Enabled"
   emulator -avd pixel35 -window-size 1080x1920 \
   -read-only -no-skin -dpi-device 96 \
   -no-metrics -no-snapshot-save  -no-snapshot-load -delay-adb -no-snapshot -no-audio \
    -camera-back none  -camera-front none -no-accel -no-boot-anim -gpu swiftshader_indirect &
fi

wait
