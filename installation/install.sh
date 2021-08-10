#!/usr/bin/env bash

packages='packages.txt'

# read package file and install everythin, eather from the oficial repository or user repository
while read line; do
   sudo pacman -S --noconfirm --needed "$line" || paru --skipreview --needed -S "$line" </dev/tty
done < $packages

echo "Insallet packages"

# Storage github user and passwor so don't ask every time
git config --global credential.helper store
