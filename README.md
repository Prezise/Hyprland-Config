
<h3 align="center">
The repo hosting all of my dotfiles for Hyprland
</h3>

## Dependencies
```sh
sudo pacman -S --needed git kitty awww swaync rofi
yay -S --needed --diffmenu waybar swayosd
```

For the default config
```sh
yay -S --needed --diffmenu hyprshot
```

## Install
To install ts bs Hyprland dotfiles you first need to clone the repo. 
```sh
git clone https://github.com/Prezise/Hyprland-Config ~/.config/themes
```

Then, you can install the provided config files for kitty, hyprland, waybar and rofi (Optional, will remove your current config, it is highly advised you back it up before proceeding)
```sh
cp -r ~/.config/themes/example-config/* ~/.config
```
Lastly, you can run the script for the first time by doing
```sh
~/.config/themes/prezise-themes.sh
```

After you select a theme for the first time, the script will be bound to Super (Windows) + Alt + Left Shift + R

## List of Keybinds

Super + Left Shift + Alt + R : Themes Menu
Super + Left Shift + R  : Reload Config

**From The default config**

Super + Q : Terminal (Kitty)
Super + C : Close Apps
Super + M : Logout
Super + E : File Manager (dolphin)
Super + V : Floating Window
Super + Tab : App Launcher (rofi)
Super + P : Pseudotile Window
Super + A : Steam
Super + F : Firefox
Super + D : Discord
Super + H : Hide Waybar (toggle on and off)
Super + Left Shift + Left Control + Alt + R : Random Theme
Super + J : Togglesplit
Super + Arrow Keys : Move between windows
Super + Number : Move between workspaces
Super + Left Shift + Number : Move windows between workspaces
Super + Right Mouse Click : Resize Windows
Super + Left Mouse Click : Move windows inside the same workspace
Print Screen : Screenshot the entire Screen
Super + Print Screen : Screenshot the selected window
Super + Left Shift + Print Screen : Screenshot only a selected square


## Using this without the provided config

To use this with your own hyprland configuration, simply add these lines to your hyprland.lua file
```lua
require("binds")
require("exec")
require("colors")
```
