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
      sudo pacman -S --needed --noconfirm git base-devel || echo "Installation failed." ; exit 1
      git clone https://aur.archlinux.org/yay.git  || echo "Installation failed." ; exit 1
      cd yay || echo "Installation failed." ; exit 1
      makepkg -si || echo "Installation failed." ; exit 1
      aur=yay
    else
      echo "You do not have an AUR helper. Aborting installation"
      exit 1
    fi
}
aurhelper
echo "Installing pacman packages..."
sudo pacman -S --needed --noconfirm kitty rofi hyprpaper swaync || echo "Installation failed." ; exit 1
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
cp -r ~/.config/themes/example-config/* ~/.config 
cp -r ~/.config/themes/Quintuplets/Miku ~/.config 
read -r -p "Precise's Hyprland config has been successfully installed. Delete this directory?" response
if [[ -z "$response" || "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
  cd ..
  rm -rf Hyprland-Config
  exit 0
else
  exit 0
fi