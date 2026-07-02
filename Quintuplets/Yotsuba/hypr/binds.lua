local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + SHIFT+R", hl.dsp.exec_cmd("~/.config/hypr/scripts/reload.sh"))
hl.bind(mainMod .. " + SHIFT+ALT+R", hl.dsp.exec_cmd("~/.config/themes/Quintuplets/themes.sh"))
