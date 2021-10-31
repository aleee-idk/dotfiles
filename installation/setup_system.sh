#!/usr/bin/env bash

packages='packages.txt'

echo "Installing packages..."
# read package file and install everythin, eather from the oficial repository or user repository
while read line; do
   sudo pacman -S --noconfirm --needed "$line" || paru --noconfirm --skipreview --needed -S "$line" </dev/tty
done < $packages

echo "Installing user config..."
"$HOME/dotfiles/installation/create_softlinks.sh"

git clone https://github.com/xero/figlet-fonts.git /tmp/figlet/
sudo mkdir -p /usr/share/figlet/fonts
sudo cp /tmp/figlet/* /usr/share/figlet/fonts/