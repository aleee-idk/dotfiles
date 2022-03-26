#!/usr/bin/env bash

## This script asume and already sorking insallation with a default user

##### Varables
username="aleidk"

hostname="arch"

locales=("#es_CL.UTF-8 UTF-8/es_CL.UTF-8 UTF-8" "#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8")

services=(
	org.cups.cupsd.service
	bluetooth
	NetworkManager
	sshd
)

##### System Configuration

echo "Timezone configuration..."

## Timezone
ln -sf /usr/share/zoneinfo/America/Santiago /etc/localtime

hwclock --systohc

echo -e "\n\n"

## Locales

echo "Locale configuratin..."

for i in "${locales[@]}"; do
    sed -i -e "s/$i/g" /etc/locale.gen
done

locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "KEYMAP=la-latin1" >> /etc/vconsole.conf

echo -e "\n\n"

## Hostname
echo "host configuration..."

echo "$hostname" > /etc/hostname

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts

echo -e "\n\n"

## Packages

packages='packages.txt'

echo "Installing packages..."
# read package file and install everythin, eather from the oficial repository or user repository
while read line; do
   sudo pacman -S --noconfirm --needed "$line" || paru --noconfirm --skipreview --needed -S "$line" </dev/tty
done < $packages

echo -e "\n\n"

echo "Installing user config..."
$HOME/dotfiles/installation/create_softlinks.sh

echo -e "\n\n"

echo "Inslling Figglet..."

git clone https://github.com/xero/figlet-fonts.git /tmp/figlet/
sudo mkdir -p /usr/share/figlet/fonts
sudo cp /tmp/figlet/* /usr/share/figlet/fonts/

## User
groupadd lpadmin
usermod -aG wheel,audio,video,optical,storage,lpadmin "$user"

## Printer

sed -i -e "s/SystemGroup sys root wheel/SystemGroup sys root wheel lpadmin/g" /etc/cups/cups-files.conf

## Services
for service in "${services[@]}"; do
	systemctl enable "$service"
done

echo "$user ALL=(ALL) ALL" > "/etc/sudoers.d/$user"
