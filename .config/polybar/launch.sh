#!/usr/bin/env bash


# env variable Orientation
# recive 'normal' or 'rotated'

readarray -d : -t screens <<< $1

# Bars:
bars=("main-normal" "secondary")


#kill already running instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

#launch bar1
if type "xrandr"; then
    # for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do

    #     case $m in
    #         $mon1 )
    #         MONITOR=$m polybar -q --reload $bar1 &;;
    #         $mon2 )
    #         MONITOR=$m polybar -q --reload $bar2 &;;
    #     esac

    # done
    for (( i=0; i < ${#screens[@]}; i++ )); do
        s=$(echo ${screens[$i]}| awk '/[a-zA-Z]+/ { print }')
        MONITOR="$s" polybar -q --reload ${bars[i]} &
    done

else
    polybar --reload example &
fi
