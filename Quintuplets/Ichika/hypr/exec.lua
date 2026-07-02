hl.on("hyprland.start", function () 
  hl.exec_cmd("swaync")
  hl.exec_cmd("swayosd-server")
  hl.exec_cmd("waybar") -- Execute waybar, hyprpaper, firefox
  hl.exec_cmd("hyprpaper") -- Execute waybar, hyprpaper, firefox
end)