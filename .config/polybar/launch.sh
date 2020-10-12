#!/usr/bin/env bash

# Monitors:
mon1="HDMI1"
mon2="eDP1"

# env variable Orientation
# recive 'normal' or 'rotated'

# Bars:
bar1="main-$orientation"
bar2="secondary"


#kill already running instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

#launch bar1
if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        
        case $m in
            $mon1 )
            MONITOR=$m polybar --reload $bar1 &;;
            $mon2 )
            MONITOR=$m polybar --reload $bar2 &;;
        esac
        
    done
else
    polybar --reload example &
fi
