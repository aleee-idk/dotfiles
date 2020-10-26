#!/bin/bash

timedatectl set-ntp true

#show partitions available
echo "$(lsblk)"
echo

echo "Enter swap partition (Eg: '/dev/sda2')"

# Ask for swap partition untl the right one is entered
while : ; do
	read swap
	swapon $swap
	if [ $? -eq 0 ]; then
	       break
	fi
	echo "wrong partition"
done
echo "$swap was mounted as swap"


echo "Enter root partition (Eg: '/dev/sda3')"
# Ask for root partition untl the right one is entered
while : ; do
	read root

	check=$(blkid -o value --match-tag TYPE $root)
	if [ $check != "ext4" ]; then
	       echo "wrong file system, please use an ext4 partition"
	       continue
	fi

	mount $root  /mnt
	if [ $? -eq 0 ]; then
	       break
	fi
	echo "wrong partition"
done
echo "$root was mounted"

# Install arch
pacstrap /mnt base linux linux-firmware sudo grub efibootmgr dosfstools os-prober mtools networkmanager base-devel git go
genfstab -U /mnt >> /mnt/etc/fstab

# Change to the new Arch instalation
cp $(dirname $(realpath $0))/post.sh /mnt/home/installation.sh
chmod +x /mnt/home/installation.sh
arch-chroot /mnt sh /home/installation.sh

rm /mnt/home/installation.sh

echo "Installation finished, reboot? (y/n)"
read answer

[[ "$answer" == "y" || "$answer" == "Y" ]] && reboot
