#!/usr/bin/env bash

wallpapers=/home/agente_a/Seguro/Wallpapers/
nfolders=3
nwallpapers=3

## Internet Connection
# wget -q --spider www.google.cl

# if [ $? -eq 0 ]; then
#     echo "Hay internet!"
# else
#     echo "no hay intert :c"
# fi

## SSH Privite Server Connection
status=$(ssh -o BatchMode=yes -o ConnectTimeout=5 berry echo ok 2>&1)

if [[ $status == ok ]] ; then
    rm  "$wallpapers"*
    ip=$( echo `ifconfig wlo1 2>/dev/null|awk '/inet / {print $2}'`)

    ssh pi@berry HOST="$ip" DIR="$wallpapers" /bin/bash <<'EOT'
    ls /disk/principal/Imagenes/Waifus | sort -R |tail -3 | while read file; do
        path=/disk/principal/Imagenes/Waifus/"$file"/"$file"_Fondos_PC/
        if [ "$(ls -A "$path")" ]; then
            cd "$path"
            ls | sort -R | tail -3 | while read line ; do
                scp "$line" agente_a@"$HOST":"$DIR"
            done
        fi
    done
EOT

elif [[ $status == "Permission denied"* ]] ; then
  echo no_auth
else
  echo other_error
fi
