#!/usr/bin/env sh

## Add this to your wm startup file.

readarray -t screens <<< $(xrandr --query | grep " connected" | cut -d" " -f1)
# Bars:
bars=("secondary" "main-normal")
# bars=("main-normal")

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
if type "xrandr"; then
    for (( i=0; i < ${#screens[@]}; i++ )); do
        s=$(echo ${screens[$i]}| awk '/[a-zA-Z]+/ { print }')
        MONITOR="$s" polybar -c ~/.config/polybar/config.ini -q --reload ${bars[i]} &
    done

else
    # Default bar
    polybar -c ~/.config/polybar/config.ini main &
fi
