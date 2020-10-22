#!/usr/bin/env bash

packages='packages.txt'
n=1

while read line; do
   sudo pacman -S --noconfirm --needed "$line" || yay -S "$line"
done < $packages

echo "Insallet packages"