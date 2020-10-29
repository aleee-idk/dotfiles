#!/bin/bash

## Variables, Edit acording
post_installation_script=post.sh
swap=/dev/sda2
root=/dev/sda3


timedatectl set-ntp true

echo "Mounting $swap as swap partition"

# Mount Swap partition, ask for one if fail
while : ; do
	swapon $swap
	if [ $? -eq 0 ]; then
	       break
	fi
	echo "The swap partition is incorrect, please enter again:"
	read swap
done
echo "$swap was mounted as swap"


echo "Mounting $root as root partition"
# Ask for root partition untl the right one is entered
while : ; do
	check=$(blkid -o value --match-tag TYPE $root)
	if [ $check == "ext4" ]; then
        mount $root  /mnt
        if [ $? -eq 0 ]; then
            break
        fi
	fi
    echo "wrong file system, please use an ext4 partition"
	read root
done
echo "$root was mounted as root"

# Install arch
pacstrap /mnt base linux linux-firmware sudo grub efibootmgr dosfstools os-prober mtools networkmanager base-devel git go
genfstab -U /mnt >> /mnt/etc/fstab

# Change to the new Arch instalation
cp $(dirname $(realpath $0))/$post_installation_script /mnt/home/installation.sh
chmod +x /mnt/home/installation.sh
arch-chroot /mnt sh /home/installation.sh

rm /mnt/home/installation.sh

echo "Installation finished, reboot? (y/n)"
read answer

[[ "$answer" == "y" || "$answer" == "Y" ]] && reboot
