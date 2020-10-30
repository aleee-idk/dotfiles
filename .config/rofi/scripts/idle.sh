#!/usr/bin/env bash

#!/usr/bin/env bash
theme=${1:-$HOME/.config/rofi/themes/sidetab.rasi}

mpd="--host 192.168.1.10 --port 6600"

mpd_playing=$(mpc $mpd -f "[[%title%|%file%] - [%album%]]" current)

mpd_status=$(mpc $mpd status)

echo $mpd_status

options="$mpd_playing
two
three
$mpd_status"
selection=$(echo "${options}" | rofi -dmenu -config $theme)
case "${selection}" in
  $mpd_playing)
    notify-send "run_rofi.sh" $mpd_playing;;
  "two")
    notify-send "run_rofi.sh" "two";;
  "three")
    notify-send "run_rofi.sh" "three";;
  $mpd_status)
    notify-send "run_rofi.sh" "mpd";;
esac
