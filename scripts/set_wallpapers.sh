#!/usr/bin/env bash

source "$HOME/dotfiles/scripts/env_variables.sh"

# Get wallpapers and convert the string output in array
# This works even if the path of some wallpapers contain a space
output=$(find "$wallpapers" -path "*Fondos_PC*" | shuf -n 5)
readarray -t finded_wallpapers <<<"$output"

# Set wallpapers
feh --bg-fill "${finded_wallpapers[@]}"

# Change colorscheme
# custom_pywal.py "$1"
