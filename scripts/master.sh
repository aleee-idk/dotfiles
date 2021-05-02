#!/usr/bin/env bash

source "$HOME/dotfiles/scripts/env_variables.sh"

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
    # ~/.config/polybar/launch.sh "$1" "$2"

    # Compositor
    killall -q picom
    while pgrep -u $UID -x picom  > /dev/null; do sleep 1; done
    picom -b --experimental-backends &

    xss-lock -l -- multilockscreen --lock &
fi

# Wallpapers
while true; do
    $HOME/dotfiles/scripts/set_wallpapers.sh
    sleep "$change_time"
done

