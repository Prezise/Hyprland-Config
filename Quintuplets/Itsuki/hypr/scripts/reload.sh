#!/bin/bash

killall -9 waybar
killall -9 swayosd-server
killall -9 mpvpaper
killall -9 swaync
swaync &
waybar &
swayosd-server &
awww img ~/.config/hypr/bg.jpg --transition-type grow
hyprctl reload
