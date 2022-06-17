#!/usr/bin/env bash
source ${HOME}/neoarch/configs/setup.conf
echo -ne "
-------------------------------------------------------------------------
               Creating Grub/systemd-boot Boot Menu
-------------------------------------------------------------------------
"
if [[ $BOOTLOADER == "systemd-boot" ]]; then
    if [[ -d "/sys/firmware/efi" ]]; then
    	bootctl install --esp-path /boot
    fi
fi

# set kernel parameter for decrypting the drive
if [[ $BOOTLOADER == "grub" ]]; then
    echo "grub install !!!"
    grub-install --debug --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --removable
    if [[ "${FS}" == "luks" ]]; then
        echo "decrypting..."
        sed -i "s/GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=${ENCRYPTED_PARTITION_UUID}:ROOT rootfstype=btrfs\"/" /etc/default/grub
        sed -i "s/#GRUB_ENABLE_CRYPTODISK=y/GRUB_ENABLE_CRYPTODISK=y/" /etc/default/grub
    else
        sed -i "'s/GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"rootfstype=${FS}\"/'" /etc/default/grub
        grub-install --debug --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --removable
    fi
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

