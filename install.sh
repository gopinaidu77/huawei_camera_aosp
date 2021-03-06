#!/bin/bash

set -e
adb push HwCamera2.signed.apk /sdcard/HwCamera2.apk
adb shell su 0 /data/local/tmp/busybox-armv6l mount -o remount,rw /system || true
adb shell su 0 mount -o remount,rw /system || true
adb shell su 0 cp /sdcard/HwCamera2.apk /system/priv-app/HwCamera2.apk
adb shell su 0 chmod 0755 /system/priv-app/HwCamera2.apk
adb shell su 0 stop
sleep 5
adb shell su 0 setprop sys.boot_completed 0
adb shell su 0 start
while ! adb shell getprop sys.boot_completed |grep -qF 1;do sleep 1;done
sleep 3
adb shell am start com.huawei.camera
