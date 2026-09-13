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
menu () {
  entries=(
    "Animated Backgrounds\0icon\x1f~/.config/themes/icons/previews/animated-backgrounds/teshiilatte.png"
    "Custom"
    "Quintessential Quintuplets\0icon\x1f~/.config/themes/icons/previews/quintuplets/main.png"
    "Random theme/background\0icon\x1f~/.config/themes/icons/$icon/question-mark.png"
  )

  option=$(printf "%b\n" "${entries[@]}" | rofi -dmenu -theme ~/.config/rofi/theme1.rasi -show-icons -p "Themes")

  case "$option" in
    "Custom") custom ;;
    "Quintessential Quintuplets") quints ;;
    "Random theme/background") ~/.config/themes/random.sh
  esac
}
quints () {
  entries=()
  for dir in ~/.config/themes/themes/Quintuplets/*/; do
      name=$(basename "${dir}")
      entries+=("${name}\0icon\x1f~/.config/themes/icons/previews/quintuplets/${name}.png")
  done
  entries+=("Random Background\0icon\x1f~/.config/themes/icons/$icon/question-mark.png")
  entries+=("...\0icon\x1f~/.config/themes/icons/$icon/back.png")

  option=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme1.rasi -show-icons -dmenu -p "Quintessential Quintuplets")

  if [ "$option" = "Random Background" ]; then
     dir=$(shuf -n1 -e ~/.config/themes/themes/Quintuplets/*)
     cp -r "${dir}"/* ~/.config
  elif [ "$option" = "..." ]; then
    menu
    return 0
  else
     cp -r ~/.config/themes/themes/Quintuplets/$option/* ~/.config
     echo "icon=white" > ~/.config/themes/theme.conf
  fi
}
random () {
  RANDOM=$$$(date +%s)
  entries=()
  for dir in ~/.config/themes/themes/*/; do
      entries+=("${dir}")
  done
  new_entries=()
  for e in "${entries[@]}"; do
    [[ "$e" != "$HOME/.config/themes/themes/custom/" ]] && new_entries+=("$e")
  done
  entries=("${new_entries[@]}")
  sdir=${entries[$RANDOM % ${#entries[@]}]}
  entries=()
  for dir in "${sdir}"*/; do
      entries+=("${dir}")
  done
  echo $entries
  fdir=${entries[$RANDOM % ${#entries[@]}]}
  echo $fdir
  cp -r $fdir/* ~/.config
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
  entries=()
  for dir in ~/.config/themes/themes/*/; do
    name=$(basename "$dir")
    entries+=("${name}")
  done
  entries+=("...\0icon\x1f~/.config/themes/icons/$icon/back.png")
  option1=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme2.rasi -dmenu -p "${roption}")
  if [ "$option1" = "..." ]; then
      ~/.config/themes/themes.sh
      return 0
  elif [ "$option1" = "Quintuplets" ]; then
    entries=()
    for dir in ~/.config/themes/themes/Quintuplets/*/; do
        name=$(basename "$dir")
        entries+=("${name}\0icon\x1f~/.config/themes/icons/previews/quintuplets/${name}.png")
    done
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
$1
reload