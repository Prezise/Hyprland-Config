#!/bin/bash

killall -9 hyprpaper
killall -9 waybar
killall -9 swayosd-server
killall -9 mpvpaper
killall -9 swaync
swaync &
waybar &
swayosd-server &
hyprpaper &
hyprctl reload
