source ${HOME}/neoarch/configs/setup.conf

if [[ -d "/sys/firmware/efi" ]]; then
	bootctl install --esp-path /mnt/boot
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

