#!/usr/bin/env bash

wallpapers="$HOME/Nextcloud/principal/Imagenes/Waifus"
change_time="20m"

# Single instance running
pid="$(pidof -x $(basename $0) -o $$)"
if [[ $? -eq 0 ]]; then
    echo "another instance running"
    kill $pid
else
    # First run
    killall -q lxsession
    while pgrep -u $UID -x lxsession  > /dev/null; do sleep 1; done
    lxsession &

    # Launch Polybar:
    ~/.config/polybar/launch.sh "$1" "$2"

    # Compositor
    killall -q picom
    while pgrep -u $UID -x picom  > /dev/null; do sleep 1; done
    picom -b --experimental-backends &
fi

# Wallpapers
while true; do
    finded_wallpapers=($(find "$wallpapers" -path "*Fondos_PC*" | shuf -n 5))
    $HOME/dotfiles/scripts/set_wallpapers.sh "${finded_wallpapers[@]}"
	sleep "$change_time"
done

