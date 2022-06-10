#!/usr/bin/env bash
echo -ne "
-------------------------------------------------------------------------
                     Installing Deaktop Sofwares
-------------------------------------------------------------------------
"
source $HOME/neoarch/configs/setup.conf
rm /var/lib/pacman/db.lck
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

echo "bash"
	cp ~/neoarch/dotfile/.bashrc ~/
echo "fonts"
	tar -xvf ~/neoarch/dotfile/font.tar -C /usr/share/fonts
echo "config"
	cp -r ~/neoarch/dotfile/.config ~/
echo "xinitrc"
	cp ~/neoarch/dotfile/.xinitrc ~/
echo "gitconfig"
	cp ~/neoarch/dotfile/.gitconfig ~/
echo "tmux"
	cp ~/neoarch/dotfile/.tmux.conf ~/
echo "nvchad"
        git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 ; nvim
        cp ~/neoarch/dotfile/custom/ ~/.config/nvim/lua
echo "rofi"
	mkdir -p ~/.local/share/rofi/themes
	cp ~/neoarch/dotfile/.config/rofi/light.rasi ~/.local/share/rofi/themes/light.rasi
echo "feh"
	mkdir ~/Desktop
	tar -xvf ~/neoarch/dotfile/neon.tar -C ~/Desktop
echo "touchpad"
	cp ~/neoarch/dotfile/30-touchpad.conf /etc/X11/xorg.conf.d
echo "dwm"
	git clone https://git.suckless.org/dwm ~/library/dwm
	cp ~/neoarch/dotfile/config.h ~/library/dwm/config.h
	cp ~/neoarch/dotfile/patch/* ~/library/dwm
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
