#!/bin/bash

# Reads the info of each of the input devices
for line in `adb shell getevent -lp 2>/dev/null | egrep -o "(/dev/input/event\S+)"`; do
  echo $line
  output=`adb shell getevent -lp $line`

  # The touchscreen device contains the keyword ABS_MT in its info
  [[ "$output" == *"ABS_MT"* ]] && { echo "TOUCHSCREEN FOUND! -> $line"; exit; }
done
echo "TOUCHSCREEN NOT FOUND!"
