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
locales=("#es_CL.UTF-8 UTF-8/es_CL.UTF-8 UTF-8")
langs=("es_CL.UTF-8")
layout=("la-latin1")
x11layout=("latin")

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

echo "127.0.0.1	localhost
::1	localhost
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

# Installing grub

mkdir /boot/EFI


echo "Mounting $efi as root partition"
# Ask for root partition untl the right one is entered
while : ; do
	check=$(blkid -o value --match-tag TYPE $efi)
	if [ $check == "vfat" ]; then
		mount $efi /boot/EFI
        if [ $? -eq 0 ]; then
            break
        fi
	fi
    echo "wrong file system, please use an EFI partition"
	lsblk -o name,fstype,size,label,partlabel,mountpoint
	read efi
done
echo "$efi was mounted as boot partition"

if [ ${#os[@]} -eq 0 ]; then
	echo "Mount another OS? (y/n)"
	read answer
	while [[ "$answer" == "y" || "$answer" == "Y" ]]; do
		lsblk -o name,fstype,size,label,partlabel,mountpoint
		read os
		while : ; do
			mkdir -p "/mnt$os"
			mount $os "/mnt$os"
			if [ $? -eq 0 ]; then
				break
			fi
			echo "wrong file system, please use an EFI partition"
			lsblk -o name,fstype,size,label,partlabel,mountpoint
			read os
		done
		echo "Mount another OS? (y/n)"
		read answer
		[[ "$answer" == "y" || "$answer" == "Y" ]] && continue
	done
else
	for i in "${os[@]}"; do
		while : ; do
			mkdir -p "/mnt$os"
			mount $os "/mnt$os"
			if [ $? -eq 0 ]; then
				echo "$os was mounted"
				break
			fi
			echo "something goes wrong"
			lsblk -o name,fstype,size,label,partlabel,mountpoint
			read os
		done
	done
fi

grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

for dir in /mnt/*; do
	umount $dir
done

# Enable Network Manager

systemctl enable NetworkManager

# Storage github user and passwor so don't ask every time
git config --global credential.helper store

# Install AUR Repository
git clone https://aur.archlinux.org/yay-git.git
chmod 777 yay-git
cd yay-git
sudo -u "$user" makepkg -si
cd ..
rm -r yay-git

# dotfiles and package install
rm -r /home/"$user"/{*,.*}
cd /home/"$user"
git clone https://github.com/aleee-idk/dotfiles.git .
cd installation

chown -R "$user":"$user" /home/"$user"/
packages='packages.txt'

# read package file and install everything, eather from the oficial repository or user repository
while read line; do
   pacman -S --noconfirm --needed "$line" || sudo -u "$user" yay -S "$line" </dev/tty
done < $packages

echo "Insalled packages"

# Install lightdm
sed -i -e "s/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g" /etc/lightdm/lightdm.conf
systemctl enable lightdm

# printer settup
sed -i -e "s/SystemGroup sys root wheel/SystemGroup sys root wheel lpadmin/g" /etc/cups/cups-files.conf
systemctl enable org.cups.cupsd.service


# for i in "${x11latout[@]}"; do
# 	echo "setting X11 layout to: $i"
#     localectl set-x11-keymap $i
# done

cp "/home/$user/installation/00-keyboard.conf" /etc/X11/xorg.conf/00-keyboard.conf

sed -i -e 's|#include "/home/.*|#include "/home/'"$user"'/.config/colors/colors"|g' /home/"$user"/.Xresources
