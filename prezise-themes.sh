#!/bin/bash
source ~/.config/themes/theme.conf
update () {
  cd $HOME/.config/themes
  cversion=$(git rev-parse HEAD)
  lversion=$(git ls-remote origin main)
  if [ "$cversion" = "$lversion" ]; then
    echo "Script is up to date!"
    return 0
  fi
  echo "Updating the script, please wait"
  git pull || echo "Update failed ;("
  echo "Update completed, reloading"
}
quints() {
  menu
}
menu () {
  entries=()
  for dir in ~/.config/themes/themes/*/; do
      name=$(basename "${dir}")
      echo $name
      entries+=("${name}\0icon\x1f~/.config/themes/icons/previews/${name}.png")
  done  
  entries+=("Random Background\0icon\x1f~/.config/themes/icons/$icon/question-mark.png")
  option=$(printf "%b\n" "${entries[@]}" | rofi -dmenu -theme ~/.config/rofi/theme1.rasi -show-icons -p "Themes")
  if [ $? -eq 1 ]; then
    exit 0
  elif [ "$option" = "custom" ]; then
    custom
    return 0
  elif [ "$option" = "Random Background" ]; then
    random
    return 0
  fi
  cd ~/.config/themes/themes/"$option"/
  pwd
  subdirectory
}
subdirectory () {
  if [ -n $1 ]; then
    cd $1
  fi
  directory=$(pwd | cut -d / -f7-)
  if [ $(pwd) = "$HOME/.config/themes/themes" ]; then
    menu
    return 0
  fi
  entries=()
  echo $directory
  for dir in $HOME/.config/themes/themes/"$directory"/*/; do
    name=$(basename "${dir}")
    echo $name
    entries+=("${name}\0icon\x1f~/.config/themes/icons/previews/${directory}/${name}.png")
  done
  entries+=("Random Background\0icon\x1f~/.config/themes/icons/$icon/question-mark.png")
  entries+=("...\0icon\x1f~/.config/themes/icons/$icon/back.png")
  option=$(printf "%b\n" "${entries[@]}" | rofi -dmenu -theme ~/.config/rofi/theme1.rasi -show-icons -p "Themes")
  if [ $? -eq 1 ]; then
    exit 0
  elif [ "$option" = "Random Background" ]; then
     random
     return 0
  elif [ "$option" = "..." ]; then
    cd ..
    subdirectory
    return 0
  fi
  cd "$option"
  if [ -n "$(find bg.jpg)" ]; then
    load
    return 0
  fi 
  subdirectory
}
icon () {
  echo $1
  path=$(echo $1 | cut -b 8-)
  mkdir $(echo "${path%/*}")
  ffmpeg -i themes/"${path}"/bg.jpg -vf "scale=256:256:force_original_aspect_ratio=increase,crop=256:256" icons/previews/"${path}".png
  exit 1
}
random () {
  entries=()
  mapfile -d '' entries < <(find . -mindepth 1 -name '.*' -prune -o -name bg.jpg -print0)
  choice="${entries[RANDOM % ${#entries[@]}]}"
  cd "${choice%/*}"
  load 
}
custom () {
  entries=()
  for dir in ~/.config/themes/themes/custom/*/; do
      name=$(basename "$dir")
      entries+=("${name}")
  done
  entries+=("...\0icon\x1f~/.config/themes/icons/$icon/back.png")
  roption=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "Custom")
  option=${roption,}
  if [ "$roption" = "..." ]; then
     ~/.config/themes/themes.sh
     return 0
  fi
  entries=(custom)
  entries+=("...\0icon\x1f~/.config/themes/icons/$icon/back.png")
  option1=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "${roption}")
  if [ "$option1" = "..." ]; then
      ~/.config/themes/themes.sh
      return 0
    entries+=("...\0icon\x1f~/.config/themes/icons/$icon/back.png")
    quint=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "Quintessential Quintuplets")
    case "$option" in
    "background") cp ~/.config/themes/themes/Quintuplets/$quint/hypr/bg.jpg ~/.config/hypr && return 0 ;; 
    "window Border") cp ~/.config/themes/themes/Quintuplets/$quint/hypr/colors.lua ~/.config/hypr && return 0 ;; 
    "...") ~/.config/themes/themes.sh ; return 0
    esac
    cd ~/.config/themes/themes/Quintuplets/$quint 
    cp -r $option ~/.config
    return 0
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
    "background") ffmpeg -i "${option2}" bg.jpg && mv bg.jpg ~/.config/hypr && return 0 ;; 
    "fastfetch") cp "${option2}" ~/.config/fastfetch && mv ~/.config/fastfetch/"${option2}" ~/.config/fastfetch/config.jsonc && return 0 ;; 
    "rofi") cp "${option2}" ~/.config/rofi && mv ~/.config/rofi/"${option2}" ~/.config/rofi/colors.rasi && return 0 ;; 
    "kitty") cp "${option2}" ~/.config/kitty && mv ~/.config/kitty/"${option2}" ~/.config/kitty/colors.conf && return 0 ;; 
    "window Border") cp "${option2}" ~/.config/hypr && mv ~/.config/hypr/"${option2}" ~/.config/hypr/colors.lua && return 0 ;; 
  esac
  cp "${option2}" ~/.config/"${option}"
  mv ~/.config/"${option}"/"${option2}" ~/.config/"${option}/style.css"
  return 0
}
load () {
 option=$(cat .assets | cut -d "%" -f 1)
 cp -r ~/.config/themes/themes/.dictionary/"${option}"/* ~/.config/
 cp bg.jpg ~/.config/hypr
}
reload () {
  killall -9 waybar
  killall -9 swayosd-server
  killall -9 mpvpaper
  killall -9 swaync
  swaync &
  waybar &
  swayosd-server &
  awww img ~/.config/hypr/bg.jpg --transition-type grow &
  hyprctl reload 
  exit 0
}
$1 $2
reload