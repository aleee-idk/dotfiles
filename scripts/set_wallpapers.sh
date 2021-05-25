#!/usr/bin/env bash


result_size=20

source "$HOME/dotfiles/scripts/env_variables.sh"
dependencies=(vimiv)

for dep in "${dependencies[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
        echo -e "$red${dep}$reset not fount!"
        exit 1
    fi
done

finish="n"

while true; do
    # Get wallpapers and convert the string output in array
    # This works even if the path of some wallpapers contain a space
    output=$(find "$wallpapers" -path "*Fondos_PC*" | shuf -n "$result_size")
    readarray -t finded_wallpapers <<<"$output"

    # Open the random wallpapers for selection
    # vimiv handle path with space itself.

    echo -e "Select at least 1 wallpaper to use
    The first wallpaper will set the color scheme and be set in the primary monitor (if you have more than one)"

    selected_wallpapers=($(vimiv --command "enter thumbnail" -o %m --set thumbnail.size 256 --set read-only "${finded_wallpapers[@]}" 2>/dev/null))

    wal -n -i "${selected_wallpapers[0]}"

    # Set wallpapers
    feh --bg-fill "${selected_wallpapers[@]}"

    echo "Is this color scheme/wallpaper fine? y/n"
    read -n 1
    [[ $REPLY =~ ^[yY]$ ]] && break
done

# Change colorscheme
# custom_pywal.py "$1"
