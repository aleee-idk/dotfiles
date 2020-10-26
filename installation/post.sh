#!/bin/bash


# Add locales to the array in the same format 'comment locale'/'uncomment locale')
locales=("#es_CL.UTF-8 UTF-8/es_CL.UTF-8 UTF-8")
langs=("es_CL.UTF-8")
layout=("la-latin1")
x11layout=("latin")

# Setting locales
echo  "Enter region for timezone (enter '?' to list aviable regions with less)"

while : ; do
	read zone
	if [ $zone == "?" ]; then
		ls /usr/share/zoneinfo/ | less
		echo "Enter region for timezone"
		read zone
	fi

	[ -e /usr/share/zoneinfo/$zone ] && break
	echo "The entered zone don't exist, try again"
done

echo  "Enter city for timezone (enter '?' to list aviable cities with less)"

while : ; do
	read city
	if [ $city == "?" ]; then
		ls /usr/share/zoneinfo/$zone | less
		echo "Enter region for timezone"
		read city
	fi

	[ -e /usr/share/zoneinfo/$zone/$city ] && break
	echo "The entered city don't exist, try again"
done

ln -sf /usr/share/zoneinfo/$zone/$city

hwclock --systohc


for i in "${locales[@]}"; do
	sed -i -e "s/$i/g" /etc/locale.gen
done

locale-gen

for i in "${langs[@]}"; do
	echo "LANG=$i" > /etc/locale.conf
done

for i in "${layout[@]}"; do
	echo "KEYMAP=$i" >> /etc/locale.conf
done

# Network Configuration

echo "Enter the hostname"
read hostname
echo "$hostname" > /etc/hostname

echo "127.0.0.1	localhost
::1	localhost
127.0.1.1 $hostname.localdomain $hostname" > /etc/host

# Users configuration

echo "Enter new password for root user"
passwd

echo "creating new user"
echo "Enter name for new user"
read user
useradd "$user"

echo "Enter password for user $user"
passwd "$user"

usermod -aG wheel,audio,video,optical,storage,lpadmin "$user"

sed -i -e "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers

# Installing grub

mkdir /boot/EFI

echo "Enter EFI Partition"
while : ; do
	read efi

	check=$(blkid -o value --match-tag TYPE $efi)
	if [ $check != "vfat" ]; then
	       echo "wrong file system, please use an EFI partition"
	       continue
	fi

	mount $efi /boot/EFI
	if [ $? -eq 0 ]; then
	       break
	fi
	echo "wrong partition"
done
echo "$efi was mounted"

grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

# Enable Network Manager

systemctl enable NetworkManager

for i in "${x11latout[@]}"; do
    localectl set-x11-keymap $i
done


# Storage github user and passwor so don't ask every time
git config --global credential.helper store

# Install AUR Repository
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd ..
rm -r yay-git

# dotfiles and package install
cd /home/"$user"
git clone https://github.com/aleee-idk/dotfiles.git
cd installation


packages='packages.txt'

# read package file and install everything, eather from the oficial repository or user repository
while read line; do
   sudo pacman -S --noconfirm --needed "$line" || yay -S "$line" </dev/tty
done < $packages

echo "Insalled packages"

# Install lightdm
sed -i -e "s/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g" /etc/lightdm/lightdm.conf
systemctl enable lightdm

# printer settup
sed -i -e "s/SystemGroup sys root wheel/SystemGroup sys root wheel lpadmin/g" /etc/cups/cups-files.conf
systemctl enable org.cups.cupsd.service
