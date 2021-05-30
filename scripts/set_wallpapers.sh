#!/usr/bin/env bash


## First Argument to filter specific folder

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

    echo -e "Select at least 1 wallpaper to use\nThe first wallpaper will set the color scheme and be set in the primary monitor (if you have more than one)"

    # Use vimiv "mark-print" to get the path of the images, you can create a keybinding like
    # Q : mark-print && quit
    readarray -t selected_wallpapers < <(find "$wallpapers" -path "*$1*Fondos_PC*" | shuf -n "$result_size" | vimiv -i --command "enter thumbnail" --set thumbnail.size 256 2>/dev/null)

    if (( "${#selected_wallpapers[@]}" == 0 )); then
        echo "Select at least 1 wallpaper"
        continue
    fi

    wal -n -i "${selected_wallpapers[0]}"

    # Set wallpapers
    feh --bg-fill "${selected_wallpapers[@]}"

    echo "Is this color scheme/wallpaper fine? y/n"
    read -n 1
    [[ $REPLY =~ ^[yY]$ ]] && break
done

awesome-client 'awesome.restart()'

# Change colorscheme
# custom_pywal.py "$1"
