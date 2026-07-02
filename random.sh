#!/bin/bash
random1=$(ls ~/.config/themes/random-backgrounds/video | wc -l)
random2=$(ls ~/.config/themes/random-backgrounds/image | wc -l)
columbina=$(ls ~/.config/themes/animated-backgrounds/Columbina/backgrounds | wc -l)
furina=$(ls ~/.config/themes/animated-backgrounds/Furina/backgrounds | wc -l)
hutao=$(ls ~/.config/themes/animated-backgrounds/hu-tao/backgrounds | wc -l)
mavuika=$(ls ~/.config/themes/animated-backgrounds/Mavuika/backgrounds | wc -l)
xilonen=$(ls ~/.config/themes/animated-backgrounds/Xilonen/backgrounds | wc -l)
quints=$(ls ~/.config/themes/Quintuplets | wc -l)
echo $random1
echo $random2
echo $columbina
echo $furina
echo $hutao
echo $mavuika
echo $xilonen
echo $quints
range=$((columbina+furina+hutao+mavuika+xilonen+quints+random1+random2))
echo $range
echo $number
number=$RANDOM
let "number %= $range"
rm ~/.config/hypr/bg.mp4 ~/.config/hypr/scripts/reload.sh
sed -i '/path = /c\    path =' ~/.config/hypr/hyprpaper.conf
sed -i '/"input-ipc-server=/tmp/mpv-socket loop"/c\exec-once = echo 1' ~/.config/hypr/exec.conf
sed -i '/exec-once = hyprpaper/c\exec-once = echo 1' ~/.config/hypr/exec.conf
echo $number
echo $range
if ((number < columbina)); then
    cp -r ~/.config/themes/animated-backgrounds/Columbina/files/* ~/.config
    dir=$(shuf -n1 -e ~/.config/themes/animated-backgrounds/Columbina/backgrounds/*)
    cp -r $dir/bg.mp4 ~/.config/hypr
fi
if ((number >= columbina && number < ((columbina+furina)))); then
    cp -r ~/.config/themes/animated-backgrounds/Furina/files/* ~/.config
    dir=$(shuf -n1 -e ~/.config/themes/animated-backgrounds/Furina/backgrounds/*)
    cp -r $dir/bg.mp4 ~/.config/hypr
fi
if ((number >= ((columbina+furina)) && number < ((columbina+furina+hutao)))); then
    cp -r ~/.config/themes/animated-backgrounds/hu-tao/files/* ~/.config
    dir=$(shuf -n1 -e ~/.config/themes/animated-backgrounds/hu-tao/backgrounds/*)
    cp -r $dir/bg.mp4 ~/.config/hypr
fi
if ((number >= ((columbina+furina+hutao)) && number < ((columbina+furina+hutao+mavuika)))); then
    cp -r ~/.config/themes/animated-backgrounds/Mavuika/files/* ~/.config
    dir=$(shuf -n1 -e ~/.config/themes/animated-backgrounds/Mavuika/backgrounds/*)
    cp -r $dir/bg.mp4 ~/.config/hypr
fi
if ((number >= ((columbina+furina+hutao+mavuika)) && number <= ((columbina+furina+hutao+mavuika+xilonen)))); then
    cp -r ~/.config/themes/animated-backgrounds/Xilonen/files/* ~/.config
    dir=$(shuf -n1 -e ~/.config/themes/animated-backgrounds/Xilonen/backgrounds/*)
    cp -r $dir/bg.mp4 ~/.config/hypr
fi
if ((number >= ((columbina+furina+hutao+mavuika+xilonen)) && number <= ((columbina+furina+hutao+mavuika+xilonen+quints)))); then
    dir=$(shuf -n1 -e ~/.config/themes/Quintuplets/*)
    cp -r $dir/* ~/.config
fi
if ((number >= ((columbina+furina+hutao+mavuika+xilonen+quints)))) ; then
    rng=$RANDOM
    let "rng %= 2"
    if ((rng = 0)) ; then
        dir=$(shuf -n1 -e ~/.config/themes/random-backgrounds/video/*) ; cp -r "$dir"/* ~/.config/
    else
        dir=$(shuf -n1 -e ~/.config/themes/random-backgrounds/image/*); cp -r "$dir"/* ~/.config/
    fi
fi
echo $dir
sed -i '/$mainMod SHIFT ALT, R/c\bind = $mainMod SHIFT ALT, R, exec, ~/.config/themes/themes.sh' ~/.config/hypr/binds.conf
~/.config/themes/move.sh
~/.config/hypr/scripts/reload.sh