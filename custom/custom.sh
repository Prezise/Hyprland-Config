#!/bin/bash

source ~/.config/themes/theme.conf
entries=(
  "Background"
  "Kitty"
  "Rofi"
  "SwayOSD"
  "Waybar"
  "Window Border"
  "...\0icon\x1f~/.config/themes/icons/$icon/back.png"
)

backgrounds=(
  "Custom"
  "Quintuplets"
  "...\0icon\x1f~/.config/themes/icons/$icon/back.png"
)

kitty=(
  "Quintuplets"
  "...\0icon\x1f~/.config/themes/icons/$icon/back.png"
)

rofi=(
  "Quintuplets"
  "...\0icon\x1f~/.config/themes/icons/$icon/back.png"
)

swayosd=(
  "Quintuplets"
  "...\0icon\x1f~/.config/themes/icons/$icon/back.png"
)

waybar=(
  "Quintuplets"
  "...\0icon\x1f~/.config/themes/icons/$icon/back.png"
)

wborders=(
  "Quintuplets"
  "...\0icon\x1f~/.config/themes/icons/$icon/back.png"
)

quintuplets=(
  "Ichika\0icon\x1f~/.config/themes/icons/previews/quintuplets/ichika.png"
  "Itsuki\0icon\x1f~/.config/themes/icons/previews/quintuplets/itsuki.png"
  "Miku\0icon\x1f~/.config/themes/icons/previews/quintuplets/miku.png"
  "Nino\0icon\x1f~/.config/themes/icons/previews/quintuplets/nino.png"
  "Yotsuba\0icon\x1f~/.config/themes/icons/previews/quintuplets/yotsuba.png"
  "...\0icon\x1f~/.config/themes/icons/$icon/back.png"
)

option=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "Quintessential Quintuplets")
case "$option" in
  "Background") option2=$(printf "%b\n" "${backgrounds[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "Backgrounds") ; option=hypr/bg.jpg ;;
  "Kitty") option2=$(printf "%b\n" "${kitty[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "Kitty") ; option=kitty ;;
  "Rofi") option2=$(printf "%b\n" "${rofi[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "Rofi") ; option=rofi ;;
  "SwayOSD") option2=$(printf "%b\n" "${swayosd[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "SwayOSD") ; option=swayosd;;
  "Waybar") option2=$(printf "%b\n" "${waybar[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "waybar") ; option=waybar ;;
  "Window Border") option2=$(printf "%b\n" "${wborders[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "Window Border") ; option=hypr/colors.lua ;;
  "...") ~/.config/themes/themes.sh ; exit 0;;
esac
case "$option2" in
  "Custom") cd ~/.config/themes/custom ; cbackground=$(ls ~/.config/themes/custom/hypr | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "Backgrounds") ;;
  "Quintuplets")cd ~/.config/themes/Quintuplets ; option3=$(printf "%b\n" "${quintuplets[@]}" | rofi -theme ~/.config/rofi/theme1.rasi -dmenu -p "Quintessential Quintuplets") ;;
  "...") ~/.config/themes/themes.sh ; exit 0;;
esac
case "$option3" in
  "Ichika") cd Ichika; cp -r --parents $option ~/.config ; ~/.config/themes/custom/custom.sh ; exit 0;;
  "Itsuki") cd Itsuki; cp -r --parents $option ~/.config ; ~/.config/themes/custom/custom.sh ; exit 0;;
  "Miku") cd Miku; cp -r --parents $option ~/.config ; ~/.config/themes/custom/custom.sh ; exit 0;;
  "Nino") cd Nino; cp -r --parents $option ~/.config ; ~/.config/themes/custom/custom.sh ; exit 0;;
  "Yotsuba") cd Yotsuba; cp -r --parents $option ~/.config ; ~/.config/themes/custom/custom.sh ; exit 0;;
  "...") ~/.config/themes/themes.sh ; exit 0;;
esac
cbackgroundpath=$(realpath hypr/$cbackground)
sed -i "/path =/c\\    path = ${cbackgroundpath}" ~/.config/hypr/hyprpaper.conf
~/.config/themes/custom/custom.sh
