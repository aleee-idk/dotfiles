#!/usr/bin/env bash

source "$HOME/dotfiles/scripts/env_variables.sh"

finded_wallpapers=($(find "$wallpapers" -path "*Fondos_PC*" | shuf -n 5))

if [[ ! -d "/tmp/lock_wallpapers" ]]; then
    mkdir /tmp/lock_wallpapers
else
    rm /tmp/lock_wallpapers/*
fi

cp "${finded_wallpapers[@]}" "/tmp/lock_wallpapers"

multilockscreen -u "/tmp/lock_wallpapers" --show-layout
