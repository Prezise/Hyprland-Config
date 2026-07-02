#!/bin/bash
if [ -f /tmp/1 ]; then
   rm /tmp/1
   waybar
else
   touch /tmp/1
   killall -9 waybar
fi
