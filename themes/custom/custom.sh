#!/bin/bash

source ~/.config/themes/theme.conf
for dir in ~/.config/themes/themes/custom/*/; do
    name=$(basename "$dir")
    entries+=("${name}")
done
entries+=("...\0icon\x1f~/.config/themes/icons/$icon/back.png")

roption=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "Custom")
option=${roption,}
if [ "$roption" = "..." ]; then
    ~/.config/themes/themes.sh
    exit 0
fi
entries=()
for dir in ~/.config/themes/themes/*/; do
  name=$(basename "$dir")
  entries+=("${name}")
done
entries+=("...\0icon\x1f~/.config/themes/icons/$icon/back.png")
option1=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "${roption}")
if [ "$option1" = "..." ]; then
    ~/.config/themes/themes.sh
    exit 0
elif [ "$option1" = "Quintuplets" ]; then
  entries=()
  for dir in ~/.config/themes/themes/Quintuplets/*/; do
      name=$(basename "$dir")
      entries+=("${name}\0icon\x1f~/.config/themes/icons/previews/quintuplets/${name}.png")
  done
  entries+=("...\0icon\x1f~/.config/themes/icons/$icon/back.png")
  quint=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "Quintessential Quintuplets")
  case "$option" in
  "background") cp ~/.config/themes/themes/Quintuplets/$quint/hypr/bg.jpg ~/.config/hypr && exit 0 ;; 
  "window Border") cp ~/.config/themes/themes/Quintuplets/$quint/hypr/colors.lua ~/.config/hypr && exit 0 ;; 
  "...") ~/.config/themes/themes.sh ; exit 0
  esac
  cd ~/.config/themes/themes/Quintuplets/$quint 
  cp -r $option ~/.config
  exit 0
fi
entries=()
cd ~/.config/themes/themes/custom/"${roption}"/
for FILE in *; do
  entries+=("${FILE}")
done
entries+=("...\0icon\x1f~/.config/themes/icons/$icon/back.png")
option2=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "${roption}")
echo $option
case $option in
  "background") ffmpeg -i "${option2}" bg.jpg && mv bg.jpg ~/.config/hypr && exit 0 ;; 
  "fastfetch") cp "${option2}" ~/.config/fastfetch && mv ~/.config/fastfetch/"${option2}" ~/.config/fastfetch/config.jsonc && exit 0 ;; 
  "rofi") cp "${option2}" ~/.config/rofi && mv ~/.config/rofi/"${option2}" ~/.config/rofi/colors.rasi && exit 0 ;; 
  "kitty") cp "${option2}" ~/.config/kitty && mv ~/.config/kitty/"${option2}" ~/.config/kitty/colors.conf && exit 0 ;; 
  "window Border") cp "${option2}" ~/.config/hypr && mv ~/.config/hypr/"${option2}" ~/.config/hypr/colors.lua && exit 0 ;; 
esac
cp "${option2}" ~/.config/"${option}"
mv ~/.config/"${option}"/"${option2}" ~/.config/"${option}/style.css"
#~/.config/hypr/scripts/reload.sh
exit 0
