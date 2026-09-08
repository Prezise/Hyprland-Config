#!/bin/bash

aurhelper () {
    which yay 
    if [ $? -eq 0 ]
    then
      aur=yay
      return 0
    fi
    which paru 
    if [ $? -eq 0 ]
    then
      aur=paru
      return 0
    fi
    read -r -p "You do not currently have an AUR helper installed. Install yay? [y/N]" response
    if [[ -z "$response" || "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
      echo "Installing yay..."
      sudo pacman -S --needed --noconfirm git base-devel 
      git clone https://aur.archlinux.org/yay.git  
      cd yay 
      makepkg -si 
      aur=yay
    else
      echo "You do not have an AUR helper. Aborting installation"
      exit 1
    fi
}
aurhelper
echo "Installing pacman packages..."
sudo pacman -S --needed --noconfirm kitty rofi awww swaync 
echo "Installing AUR packages ..."
if [ "$aur" == yay ]
then 
  yay -S --needed --diffmenu --noconfirm hyprshot waybar mpvpaper swayosd
  echo "Packages installed successfully"
else
  paru -S --needed --skipreview --noconfirm hyprshot waybar mpvpaper swayosd
  echo "Packages installed successfully"
fi
echo "Cloning files into the main themes directory"
mkdir ~/.config/themes
cp -r * ~/.config/themes
rm ~/.config/themes/install.sh
read -r -p "Precise's Hyprland config has been successfully installed. Load the default config? (this will delete whatever config you currently have)" response
if [[ -z "$response" || "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
  cp -r ~/.config/themes/example-config/* ~/.config 
cp -r ~/.config/themes/Quintuplets/Miku ~/.config 
