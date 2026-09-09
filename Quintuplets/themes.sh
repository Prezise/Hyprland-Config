#!/bin/bash
source ~/.config/themes/theme.conf
echo x1f~/.config/themes/icons/$icon/back.png
echo $icon
entries=()
for dir in ~/.config/themes/Quintuplets/*/; do
    name=$(basename "$dir")
    entries+=("${name}\0icon\x1f~/.config/themes/icons/previews/quintuplets/${name}.png")
done
entries+=("Random Background\0icon\x1f~/.config/themes/icons/$icon/question-mark.png")
entries+=("...\0icon\x1f~/.config/themes/icons/$icon/back.png")

option=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme1.rasi -show-icons -dmenu -p "Quintessential Quintuplets")

if [ option="Random Background" ]; then
    dir=$(shuf -n1 -e ~/.config/themes/Quintuplets/*)
    cp -r $dir/* ~/.config
elif [ option="..." ]; then
    ~/.config/themes/themes.sh
    exit 0
else
    cp -r ~/.config/themes/Quintuplets/$option/* ~/.config
    echo "icon=white" > ~/.config/themes/theme.conf
fi

if [ $? -ne 0 ]; then
    exit 0
fi
~/.config/hypr/scripts/reload.sh