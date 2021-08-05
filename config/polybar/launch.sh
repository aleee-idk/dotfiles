#!/usr/bin/env bash

## Add this to your wm startup file.

readarray -t screens <<< $(xrandr --query | grep " connected" | cut -d" " -f1)
# Bars:
declare -A bars
bars[HDMI1]="desktops system"
bars[eDP1]="desktops"
# bars=("main-normal")

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
if type "xrandr"; then
    for s in "${screens[@]}"; do
		for b in ${bars[$s]}; do
			MONITOR="$s" polybar -c ~/.config/polybar/config.ini -q --reload "$b" &
		done
    done
fi
