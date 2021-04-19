#!/bin/bash

# Import common variables
source "$HOME/dotfiles/scripts/env_variables.sh"

entries=("${!common_folders[@]}" "${recent_folders[@]}")

prompt="Open in terminal..."
choice=$(printf '%s\n' "${entries[@]}" | sort | rofi -dmenu -p "$prompt")

# What to do...
if [ "$choice" ]; then
  cfg=${common_folders["${choice}"]}
  if [[ -n "$cfg" ]]; then
	  $terminal_directory "$cfg"
  else
	  $terminal_directory "$choice"
  fi

# What to do if we just escape without choosing anything.
else
    echo "Program terminated." && exit 0
fi
