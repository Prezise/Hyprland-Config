#!/bin/bash
source ~/.config/themes/theme.conf
echo x1f~/.config/themes/icons/$icon/back.png
echo $icon

entries=(
  "Ichika\0icon\x1f~/.config/themes/icons/previews/quintuplets/ichika.png"
  "Itsuki\0icon\x1f~/.config/themes/icons/previews/quintuplets/itsuki.png"
  "Miku\0icon\x1f~/.config/themes/icons/previews/quintuplets/miku.png"
  "Nino\0icon\x1f~/.config/themes/icons/previews/quintuplets/nino.png"
  "Yotsuba\0icon\x1f~/.config/themes/icons/previews/quintuplets/yotsuba.png"
  "Random Background\0icon\x1f~/.config/themes/icons/$icon/question-mark.png"
  "...\0icon\x1f~/.config/themes/icons/$icon/back.png"
)

option=$(printf "%b\n" "${entries[@]}" | rofi -theme ~/.config/rofi/theme1.rasi -show-icons -dmenu -p "Quintessential Quintuplets")

case "$option" in
  "Ichika") cp -r ~/.config/themes/Quintuplets/Ichika/* ~/.config ; echo "icon=white" > ~/.config/themes/theme.conf ;;
  "Itsuki") cp -r ~/.config/themes/Quintuplets/Itsuki/* ~/.config ; echo "icon=white" > ~/.config/themes/theme.conf ;;
  "Miku") cp -r ~/.config/themes/Quintuplets/Miku/* ~/.config ; echo "icon=white" > ~/.config/themes/theme.conf ;;
  "Nino") cp -r ~/.config/themes/Quintuplets/Nino/* ~/.config ; echo "icon=white" > ~/.config/themes/theme.conf ;;
  "Yotsuba") cp -r ~/.config/themes/Quintuplets/Yotsuba/* ~/.config ; echo "icon=white" > ~/.config/themes/theme.conf ;;
  "Random Background") dir=$(shuf -n1 -e ~/.config/themes/Quintuplets/*) ; cp -r $dir/* ~/.config ;;
  "...") ~/.config/themes/themes.sh ; exit 0;;
esac

~/.config/hypr/scripts/reload.sh

exit 0