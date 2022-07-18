#!/usr/bin/env bash

## Add this to your wm startup file.

readarray -t screens <<<$(xrandr --query | grep " connected" | cut -d" " -f1)
# Bars:
declare -A bars
bars["HDMI-A-0"]="main"
bars["HDMI-A-1"]="main"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
if type "xrandr"; then
	for s in "${screens[@]}"; do
		for b in ${bars[$s]}; do

			[[ $s == 'HDMI-A-1' ]] && bottom="true" || bottom="false"

			MONITOR="$s" BOTTOM="$bottom" polybar -c ~/.config/polybar/config.ini -q --reload "$b" &
		done
	done
fi
