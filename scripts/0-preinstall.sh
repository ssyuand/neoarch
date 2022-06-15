#!/usr/bin/env bash
source $CONFIGS_DIR/setup.conf
iso=$(curl -4 ifconfig.co/country-iso)
rm /var/lib/pacman/db.lck
pacman -Sy --noconfirm --needed
pacman -S --noconfirm archlinux-keyring #update keyrings to latest to prevent packages failing to install
pacman -S --noconfirm --needed pacman-contrib terminus-font
pacman -S --noconfirm --needed reflector rsync
setfont ter-v22b
timedatectl set-ntp true

if [[ $BOOTLOADER == "grub" ]]; then
    pacman -S --noconfirm --needed grub
fi

echo -ne "
-------------------------------------------------------------------------
                    Setting up $iso mirrors for faster downloads
-------------------------------------------------------------------------
"
sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i 's/^#NoProgressBar/DisableDownloadTimeout/' /etc/pacman.conf
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
reflector  --download-timeout 5 -a 48 --protocol https -c $iso -l 20 --sort rate --save /etc/pacman.d/mirrorlist
mkdir /mnt &>/dev/null # Hiding error message if any
echo -ne "
-------------------------------------------------------------------------
                    Installing Prerequisites
-------------------------------------------------------------------------
"
pacman -S --noconfirm --needed gptfdisk btrfs-progs glibc
echo -ne "
-------------------------------------------------------------------------
                    Formating Disk
-------------------------------------------------------------------------
"
umount -A --recursive /mnt # make sure everything is unmounted before we start
# disk prep
sgdisk -Z ${DISK} # zap all on disk
sgdisk -a 2048 -o ${DISK} # new gpt disk 2048 alignment

# create partitions
sgdisk -n 1::+300M --typecode=1:ef00 --change-name=1:'EFIBOOT' ${DISK} # partition 1 (UEFI Boot Partition)
sgdisk -n 2::-0 --typecode=2:8300 --change-name=2:'ROOT' ${DISK} # partition 2 (Root), default start, remaining
partprobe ${DISK} # reread partition table to ensure it is correct
echo -ne "
-------------------------------------------------------------------------
                    Creating Filesystems
-------------------------------------------------------------------------
"
createsubvolumes () {
    btrfs subvolume create /mnt/@
    btrfs subvolume create /mnt/@home
    btrfs subvolume create /mnt/@var
    btrfs subvolume create /mnt/@tmp
    btrfs subvolume create /mnt/@.snapshots
}

# @description Mount all btrfs subvolumes after root has been mounted.
mountallsubvol () {
    mount -o ${MOUNT_OPTIONS},subvol=@home /dev/mapper/ROOT /mnt/home
    mount -o ${MOUNT_OPTIONS},subvol=@tmp /dev/mapper/ROOT /mnt/tmp
    mount -o ${MOUNT_OPTIONS},subvol=@var /dev/mapper/ROOT /mnt/var
    mount -o ${MOUNT_OPTIONS},subvol=@.snapshots /dev/mapper/ROOT  /mnt/.snapshots
}

# @description BTRFS subvolulme creation and mounting. 
subvolumesetup () {
# create nonroot subvolumes
    createsubvolumes     
# unmount root to remount with subvolume 
    umount /mnt
# mount @ subvolume
    mount -o ${MOUNT_OPTIONS},subvol=@ /dev/mapper/ROOT /mnt
# make directories home, .snapshots, var, tmp
    mkdir -p /mnt/{home,var,tmp,.snapshots}
# mount subvolumes
    mountallsubvol
}

if [[ "${DISK}" =~ "nvme" ]]; then
    partition1=${DISK}p1
    partition2=${DISK}p2
else
    partition1=${DISK}1
    partition2=${DISK}2
fi

if [[ "${FS}" == "btrfs" ]]; then
    mkfs.vfat -F32 -n "EFIBOOT" ${partition1}
    mkfs.btrfs -L ROOT ${partition2} -f
    mount -t btrfs ${partition2} /mnt
    subvolumesetup
elif [[ "${FS}" == "ext4" ]]; then
    mkfs.vfat -F32 -n "EFIBOOT" ${partition1}
    mkfs.ext4 -L ROOT ${partition2}
    mount -t ext4 ${partition2} /mnt
elif [[ "${FS}" == "luks" ]]; then
    mkfs.vfat -F32 -n "EFIBOOT" ${partition1}
# enter luks password to cryptsetup and format root partition
    echo -n "${LUKS_PASSWORD}" | cryptsetup -q -y -v luksFormat ${partition2} -
# open luks container and ROOT will be place holder 
    echo -n "${LUKS_PASSWORD}" | cryptsetup open ${partition2} ROOT -
# now format that container
    mkfs.btrfs -f -L ROOT /dev/mapper/ROOT
# create subvolumes for btrfs
    mount -t btrfs /dev/mapper/ROOT /mnt
    subvolumesetup
# store uuid of encrypted partition for grub
    echo ENCRYPTED_PARTITION_UUID=$(blkid -s UUID -o value ${partition2}) >> $CONFIGS_DIR/setup.conf
fi

# mount target
mkdir -p /mnt/boot/efi
mount -t vfat -L EFIBOOT /mnt/boot/

#set fonts
mkdir -p /mnt/usr/share/fonts
tar -xvf ~/neoarch/dotfile/font.tar -C /mnt/usr/share/fonts

if ! grep -qs '/mnt' /proc/mounts; then
    echo "Drive is not mounted can not continue"
    echo "Rebooting in 3 Seconds ..." && sleep 1
    echo "Rebooting in 2 Seconds ..." && sleep 1
    echo "Rebooting in 1 Second ..." && sleep 1
    reboot now
fi
echo -ne "
-------------------------------------------------------------------------
                    Arch Install on Main Drive
-------------------------------------------------------------------------
"
pacstrap /mnt base base-devel linux linux-firmware neovim sudo archlinux-keyring btrfs-progs --noconfirm --needed
cp -R ${SCRIPT_DIR} /mnt/root/neoarch
cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist

genfstab -L /mnt >> /mnt/etc/fstab
echo " 
  Generated /etc/fstab:
"
cat /mnt/etc/fstab
echo -ne "
-------------------------------------------------------------------------
                     Bootloader Install & Check
-------------------------------------------------------------------------
"
source $CONFIGS_DIR/setup.conf
if [[ $BOOTLOADER == "grub" ]]; then
    if [[ ! -d "/sys/firmware/efi" ]]; then
        grub-install --boot-directory=/mnt/boot ${DISK}
    else
        pacstrap /mnt efibootmgr grub --noconfirm --needed
    fi
fi
if [[ $BOOTLOADER == "systemd-boot" ]]; then
    bootctl install --esp-path /mnt/boot
    printf "default arch\ntimeout 0" > /mnt/boot/loader/loader.conf
    printf "title ouch\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img\noptions cryptdevice=UUID=$ENCRYPTED_PARTITION_UUID:ROOT rootflags=subvol=@ root=/dev/mapper/ROOT rw" > /mnt/boot/loader/entries/arch.conf
fi
echo -ne "
-------------------------------------------------------------------------
                    SYSTEM READY FOR 1-setup.sh
-------------------------------------------------------------------------
"
