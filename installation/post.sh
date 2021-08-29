#!/bin/bash


## Add locales to the array in the same format 'comment locale'/'uncomment locale')

# Names:
hostname="archtest"
user="aleidk"
userpass="0000"
rootpass="0000"

# Partitions:
efi="/dev/sda1"
os=("/dev/sda4")

# locales
zone="Chile"
city="Continental"
locales=("#es_CL.UTF-8 UTF-8/es_CL.UTF-8 UTF-8" "#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8")
langs=("en_US.UTF-8")
layout=("la-latin1")
x11layout=("latin")

# packages
packages='packages.txt'

# Services
services=(org.cups.cupsd.service bluetooth)

# Setting locales

while : ; do
    [ -e /usr/share/zoneinfo/$zone ] && break

    echo "The entered zone don't exist, try again"
    echo  "Enter region for timezone (enter '?' to list aviable regions with less)"
    read zone
    if [ $zone == "?" ]; then
        ls /usr/share/zoneinfo/ | less
        echo "Enter region for timezone"
        read zone
    fi
done


while : ; do
    [ -e /usr/share/zoneinfo/$zone/$city ] && break

    echo "The entered city don't exist, try again"
    echo  "Enter city for timezone (enter '?' to list aviable cities with less)"
    read city
    if [ $city == "?" ]; then
        ls /usr/share/zoneinfo/$zone | less
        echo "Enter region for timezone"
        read city
    fi
done

ln -sf /usr/share/zoneinfo/$zone/$city /etc/localtime

hwclock --systohc


for i in "${locales[@]}"; do
    sed -i -e "s/$i/g" /etc/locale.gen
done

locale-gen

for i in "${langs[@]}"; do
    echo "LANG=$i" > /etc/locale.conf
done

for i in "${layout[@]}"; do
    echo "KEYMAP=$i" >> /etc/vconsole.conf
done

# Network Configuration

if [ -z $hostname ]; then
    echo "Enter the hostname"
    read hostname
fi

echo "$hostname" > /etc/hostname

echo "127.0.0.1 localhost
::1 localhost
127.0.1.1 $hostname.localdomain $hostname" > /etc/host

# Users configuration

echo "Seeting Root password"
if [ -z $rootpass  ]; then
    while : ; do
        passwd
        [ $? -eq 0 ] && break
        echo "Please try again"
    done
else
    echo -e "$rootpass\n$rootpass" | passwd
fi


echo "Creating new user"

if [ -z $user ]; then
    while : ; do
        echo "Enter name for new user"
        read user
        useradd -m "$user"
        [ $? -eq 0 ] && break
        echo "Please try again"
    done
else
    useradd -m "$user"
fi


echo "Seeting password for $user user"
if [ -z $userpass ]; then
    while : ; do
        passwd "$user"
        [ $? -eq 0 ] && break
        echo "Please try again"
    done
else
    echo -e "$userpass\n$userpass" | passwd "$user"
fi

groupadd lpadmin
usermod -aG wheel,audio,video,optical,storage,lpadmin "$user"

sed -i -e "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers

# Enable Network Manager

systemctl enable NetworkManager

# Storage github user and passwor so don't ask every time
git config --global credential.helper store

# Install AUR Repository

# TODO

# dotfiles and package install
cd /home/"$user"
git clone https://github.com/aleee-idk/dotfiles.git
cd dotfiles/installation

chown -R "$user":"$user" /home/"$user"/
packages='packages.txt'

echo "Installing packages..."
# read package file and install everythin, eather from the oficial repository or user repository
while read line; do
   sudo pacman -S --noconfirm --needed "$line" || paru --noconfirm --skipreview --needed -S "$line"
done < $packages

echo "Insalled packages"

# printer settup
sed -i -e "s/SystemGroup sys root wheel/SystemGroup sys root wheel lpadmin/g" /etc/cups/cups-files.conf

for service in "${services[@]}"; do
	systemctl enable "$service"
done

# for i in "${x11latout[@]}"; do
#   echo "setting X11 layout to: $i"
#     localectl set-x11-keymap $i
# done

cp -v "/home/$user/installation/00-keyboard.conf" /etc/X11/xorg.conf.d/00-keyboard.conf
cp -v "/home/$user/installation/10-monitor.conf" /etc/X11/xorg.conf.d/10-monitor.conf

sed -i -e 's|#include "/home/.*|#include "/home/'"$user"'/.config/colors/colors"|g' /home/"$user"/.Xresources
