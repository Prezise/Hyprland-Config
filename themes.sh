#!/bin/bash
source ~/.config/themes/theme.conf

entries=(
  "Animated Backgrounds\0icon\x1f~/.config/themes/icons/previews/animated-backgrounds/teshiilatte.png"
  "Custom"
  "Quintessential Quintuplets\0icon\x1f~/.config/themes/icons/previews/quintuplets/main.png"
  "Random theme/background\0icon\x1f~/.config/themes/icons/$icon/question-mark.png"
)

option=$(printf "%b\n" "${entries[@]}" | rofi -dmenu -theme ~/.config/rofi/theme1.rasi -show-icons -p "Themes")

case "$option" in
  "Animated Backgrounds") ~/.config/themes/animated-backgrounds/themes.sh ;;
  "Custom") ~/.config/themes/custom/custom.sh ;;
  "Quintessential Quintuplets") ~/.config/themes/Quintuplets/themes.sh ;;
  "Random theme/background") ~/.config/themes/random.sh
esac


