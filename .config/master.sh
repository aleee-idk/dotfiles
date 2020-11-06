#!/usr/bin/env bash

## pass the following arguments: "Screens separated by ':'" "Current layout"

wallpapers=/home/aleidk/Seguro/Wallpapers/
nfolders=3
nwallpapers=3

## Internet Connection
# wget -q --spider www.google.cl

# if [ $? -eq 0 ]; then
#     echo "Hay internet!"
# else
#     echo "no hay intert :c"
# fi

# Launch Polybar:
~/.config/polybar/launch.sh "$1" "$2"

# Compositor
killall -q picom
sleep 1
picom -b --experimental-backends


## SSH Privite Server Connection
status=$(ssh -o BatchMode=yes -o ConnectTimeout=5 berry echo ok 2>&1)

if [[ $status == ok ]] ; then
    rm  "$wallpapers"*
    ip=$(echo `ip address show wlo1 2>/dev/null|awk '/inet / {print $2}' | awk -F"/" '{print $1}'`)

    ssh pi@berry HOST="$ip" DIR="$wallpapers" /bin/bash <<'EOT'
    ls /disk/principal/Imagenes/Waifus | sort -R |tail -3 | while read file; do
        path=/disk/principal/Imagenes/Waifus/"$file"/"$file"_Fondos_PC/
        if [ "$(ls -A "$path")" ]; then
            cd "$path"
            ls | sort -R | tail -3 | while read line ; do
                scp "$line" aleidk@"$HOST":"$DIR"
            done
        fi
    done
EOT

elif [[ $status == "Permission denied"* ]] ; then
  echo no_auth
else
  echo other_error
fi


# Wallpapers
feh --randomize --bg-fill "$wallpapers"*

