local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + SHIFT+R", hl.dsp.exec_cmd("prezise-themes reload"))
hl.bind(mainMod .. " + SHIFT+ALT+R", hl.dsp.exec_cmd("prezise-themes quints"))
