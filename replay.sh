#!/bin/bash

echo "🔎 Looking for touchscreen device..."
DEVICE_TOUCHSCREEN=`./device_touchscreen.sh`

echo "$DEVICE_TOUCHSCREEN"

# Check if the file `event_arm64` exists in the phone
event_arm64=`adb shell ls /data/local/tmp/event_arm64 2>&1`

# Push event to device
echo "❇️ $event_arm64"
[[ "$event_arm64" == *"No such file or directory"* ]] && adb push event_arm64 /data/local/tmp/

adb push touch_records.txt /sdcard/

# Replay the recorded touchevents
adb shell /data/local/tmp/event_arm64 "${DEVICE_TOUCHSCREEN#*-> }" /sdcard/touch_records.txt