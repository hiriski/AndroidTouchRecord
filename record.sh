#!/bin/bash

echo "🔎 Looking for touchscreen device..."

DEVICE_TOUCHSCREEN=`./device_touchscreen.sh`

# Min SDK version
MIN_VERSION=23

# Get android version
ANDROID_VERSION_STR=`adb shell getprop ro.build.version.sdk`

# Convert android version string to integer
ANDROID_VERSION=$(echo "$ANDROID_VERSION_STR"| tr -d $'\r' | bc)

echo "$DEVICE_TOUCHSCREEN"

# Check if input device exists
if [[ "$DEVICE_TOUCHSCREEN" = *"TOUCHSCREEN FOUND!"* ]]
then
    echo -e "SDK version: $ANDROID_VERSION\n"

    # Device found! Start recording
    echo "❇️ Recoding will start at the first touch"
    echo "⛔️ Press CTRL+C to STOP recording"

    if (( ANDROID_VERSION > MIN_VERSION )); then
        #exec-out is shell without buffering, fixing missing last touch data event
        adb exec-out getevent -t "${DEVICE_TOUCHSCREEN#*-> }" > touch_records.txt
    else
        # If android SDK Version <= 23
        adb shell getevent -t "${DEVICE_TOUCHSCREEN#*-> }" > touch_records.txt
    fi
fi