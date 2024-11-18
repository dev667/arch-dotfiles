#!bin/bash


# The purpose of this script is to install all required packages for my arch system.

sudo pacman -Syu
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git ~/build/yay

cd ~/build/yay
makepkg -sci
makepkg -c --noconfirm
yay --version
cd
