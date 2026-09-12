local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + SHIFT+R", hl.dsp.exec_cmd("~/.config/themes/prezise-themes.sh reload"))
hl.bind(mainMod .. " + SHIFT+ALT+R", hl.dsp.exec_cmd("~/.config/themes/prezise-themes.sh quints"))
