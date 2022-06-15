#!/usr/bin/env bash
echo -ne "
-------------------------------------------------------------------------
                     Installing Deaktop Sofwares
-------------------------------------------------------------------------
"
source $HOME/neoarch/configs/setup.conf
sudo pacman -Sy --noconfirm --needed
sed -n '/'END'/q;p' ~/neoarch/pkg-files/${DESKTOP_ENV}.txt | while read line
do
  echo "INSTALLING: ${line}"
  sudo pacman -S --noconfirm --needed ${line}
done

echo -ne "
-------------------------------------------------------------------------
                     Installing AUR Softwares
-------------------------------------------------------------------------
"
if [[ ! $AUR_HELPER == none ]]; then
  mkdir ~/library
  git clone "https://aur.archlinux.org/$AUR_HELPER.git" ~/library/$AUR_HELPER
  cd ~/library/$AUR_HELPER && makepkg -si --noconfirm
  sed -n '/'END'/q;p' ~/neoarch/pkg-files/aur-pkgs.txt | while read line
  do
    echo "INSTALLING: ${line}"
    $AUR_HELPER -S --noconfirm --needed ${line}
  done
fi

echo -ne "
-------------------------------------------------------------------------
                     Installing env Softwares
-------------------------------------------------------------------------
"
export PATH=$PATH:~/.local/bin
if [[ $DESKTOP_ENV == "dwm" ]]; then
echo "netctl"
        sudo cp ~/neoarch/configs/wlan0 /etc/netctl
        sudo netctl enable wlan0
echo "case-insensitive"
        echo 'set completion-ignore-case On' | sudo tee -a /etc/inputrc
echo "bash"
	cp ~/neoarch/configs/.bashrc ~/
echo "fonts"
	sudo tar -xvf ~/neoarch/configs/etc/font.tar -C /usr/share/fonts
echo "config"
	cp -r ~/neoarch/configs/.config ~/
echo "xinitrc"
	cp ~/neoarch/configs/.xinitrc ~/
echo "gitconfig"
	cp ~/neoarch/configs/.gitconfig ~/
echo "tmux"
	cp ~/neoarch/configs/.tmux.conf ~/
echo "nvchad"
        git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
        cp -r ~/neoarch/configs/custom/ ~/.config/nvim/lua
echo "rofi"
	mkdir -p ~/.local/share/rofi/themes
	cp ~/neoarch/configs/.config/rofi/light.rasi ~/.local/share/rofi/themes/light.rasi
echo "feh"
	mkdir ~/Desktop
	tar -xvf ~/neoarch/configs/etc/wallpaper.tar -C ~/Desktop
echo "touchpad"
	sudo cp ~/neoarch/configs/30-touchpad.conf /etc/X11/xorg.conf.d
echo "dwm"
	git clone https://git.suckless.org/dwm ~/library/dwm
	cp ~/neoarch/configs/config.h ~/library/dwm/config.h
	cp ~/neoarch/configs/patch/* ~/library/dwm
	cd ~/library/dwm
echo "patch"
	patch -p1 < ru_fib_gap.diff
	patch -p1 < uselessgap.diff
	patch -p1 < pertag.diff
	patch -p1 < fackfullscreen.diff
	sudo make install
echo "fcitx"
	fcitx5 &
	git clone https://github.com/catppuccin/fcitx5.git ~/library/fcitx5
	mkdir -p ~/.local/share/fcitx5/themes/
	cp -r ~/library/fcitx5/Catppuccin ~/.local/share/fcitx5/themes
	echo "Theme=Catppuccin" > ~/.config/fcitx5/conf/classicui.conf

elif [[ $DESKTOP_ENV == "kde" ]]; then
  cp -r ~/neoarch/configs/.config/* ~/.config/
  pip install konsave
  konsave -i ~/neoarch/configs/kde.knsv
  sleep 1
  konsave -a kde
elif [[ $DESKTOP_ENV == "openbox" ]]; then
  cd ~
  git clone https://github.com/stojshic/dotfiles-openbox
  ./dotfiles-openbox/install-titus.sh
fi

echo -ne "
-------------------------------------------------------------------------
                    SYSTEM READY FOR 3-post-setup.sh
-------------------------------------------------------------------------
"
exit
