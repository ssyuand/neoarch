#!/usr/bin/env bash
source ${HOME}/neoarch/configs/setup.conf
echo -ne "
-------------------------------------------------------------------------
               Creating Grub/systemd-boot Boot Menu
-------------------------------------------------------------------------
"
if [[ $BOOTLOADER == "systemd-boot" ]]; then
    if [[ -d "/sys/firmware/efi" ]]; then
    	bootctl install --esp-path /mnt/boot
    fi
fi

if [[ $BOOTLOADER == "grub" ]]; then
    if [[ -d "/sys/firmware/efi" ]]; then
        grub-install --efi-directory=/boot ${DISK}
    fi
# set kernel parameter for decrypting the drive
if [[ "${FS}" == "luks" ]]; then
    sed -i "s%GRUB_CMDLINE_LINUX_DEFAULT=\"%GRUB_CMDLINE_LINUX_DEFAULT=\"cryptdevice=UUID=${ENCRYPTED_PARTITION_UUID}:ROOT root=/dev/mapper/ROOT %g" /etc/default/grub
fi
# set kernel parameter for adding splash screen
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& splash /' /etc/default/grub

echo -e "Updating grub..."
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "All set!"
fi

echo -ne "
-------------------------------------------------------------------------
                    Enabling Essential Services
-------------------------------------------------------------------------
"
echo "iwd enabled"
	systemctl enable iwd
echo "ssh enabled"
	systemctl enable sshd
echo "DHCP disabled"
	systemctl disable dhcpcd.service
echo "NetworkManager enabled"
	systemctl enable NetworkManager.service
echo "Bluetooth enabled"
	systemctl enable bluetooth
echo "Avahi enabled"
	systemctl enable avahi-daemon.service

echo "Auto Enable Bluetooth"
        sed -i -e 's/^#AutoEnable=false/AutoEnable=true/g' /etc/bluetooth/main.conf


#if [[ "${FS}" == "luks" || "${FS}" == "btrfs" ]]; then
#echo -ne "
#-------------------------------------------------------------------------
#                    Creating Snapper Config
#-------------------------------------------------------------------------
#"
#
#SNAPPER_CONF="$HOME/etc/snapper/configs/root"
#mkdir -p /etc/snapper/configs/
#cp -rfv ${SNAPPER_CONF} /etc/snapper/configs/
#
#SNAPPER_CONF_D="$HOME/etc/conf.d/snapper"
#mkdir -p /etc/conf.d/
#cp -rfv ${SNAPPER_CONF_D} /etc/conf.d/
#fi

echo -ne "
-------------------------------------------------------------------------
                    Cleaning
-------------------------------------------------------------------------
"
# Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
sed -i 's/^%wheel ALL=(ALL:ALL) NOPASSWD: ALL/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Replace in the same state
cd $pwd

