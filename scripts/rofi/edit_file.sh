#!/bin/bash

# Import common variables
source "$HOME/dotfiles/scripts/env_variables.sh"

entries=("${!common_folders[@]}" "${recent_folders[@]}")

# We use "printf '%s\n'" to format the array one item to a line.
choice=$(printf '%s\n' "${entries[@]}" | sort | rofi -dmenu -p 'Edit config')

# What to do when/if we choose a file to edit.
if [ "$choice" ]; then
    cfg=$(printf '%s\n' "${common_entries["${choice}"]}")
    if [[ -n "$cfg" ]]; then
        $terminal_directory "$cfg" $editor
    else
        $terminal_directory "$choice" $editor
    fi

# What to do if we just escape without choosing anything.
else
    echo "Program terminated." && exit 0
fi
