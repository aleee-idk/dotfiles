#!/usr/bin/env bash


#  ____            _
# | __ )  __ _ ___| |__
# |  _ \ / _` / __| '_ \
# | |_) | (_| \__ \ | | |
# |____/ \__,_|___/_| |_|
#

# Fail if something goes wrowg
set -euo pipefail

# Common rofi command, don't surround the variable with quotes because it
# doesn't pick the theme (idk why)
rofi_theme="-theme $HOME/.config/rofi/themes/sidebar.rasi"

# List of some cool scripts: https://github.com/cjbassi/awesome-rofi

# Installed scripts
declare -A scripts
scripts["Emoji"]="-show emoji -modi emoji"												# https://github.com/Mange/rofi-emoji
scripts["Calculator"]="-show calc -modi calc -no-show-match -no-sort"					# https://github.com/svenstaro/rofi-calc
scripts["Udiskie"]="udiskie-dmenu -matching regex -dmenu -i -no-custom -multi-select"	# https://github.com/fogine/udiskie-dmenu
scripts["Power Menu"]="-show p -modi p:rofi-power-menu"									# https://github.com/jluttine/rofi-power-menu

# Fill with custom scripts
# scripts+=($HOME/dotfiles/scripts/rofi/*)
for file in $HOME/dotfiles/scripts/rofi/*; do
	scripts[$(basename "$file")]="$file"
done

# Some env variables needed for the scripts
export UDISKIE_DMENU_LAUNCHER="rofi" 


choice="$(printf '%s\n' "${!scripts[@]}" | rofi $rofi_theme -sort -dmenu -p "Select Script")"

cmd=${scripts["$choice"]}

if [[ -e $cmd ]]; then
	"$cmd"
else
	rofi $cmd $rofi_theme
fi

