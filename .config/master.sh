#!/usr/bin/env bash

wallpapers="$HOME/Nextcloud/principal/Imagenes/Waifus"
change_time="20m"

killall -q lxsession
while pgrep -u $UID -x lxsession  > /dev/null; do sleep 1; done
lxsession &

# Launch Polybar:
~/.config/polybar/launch.sh "$1" "$2"

# Compositor
killall -q picom
while pgrep -u $UID -x picom  > /dev/null; do sleep 1; done
picom -b --experimental-backends &

# Wallpapers
while true; do
	feh --bg-fill $(find "$wallpapers" -path "*Fondos_PC*" | shuf -n 5)
	sleep "$change_time"
done

