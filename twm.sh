#!/bin/bash

sudo systemctl start NetworkManager.service
sudo systemctl enable NetworkManager.service

sudo pacman -Syu xorg-server xorg-xinit xorg-xinput xf86-video-nouveau mesa mesa-libgl libvdpau-va-gl xf86-input-libinput python3 python-pip qtile lightdm lightdm-gtk-greeter alacritty zip unzip curl unrar git firefox opera opera-ffmpeg-codecs rofi lsd bat wget brightnessctl redshift picom feh  exa lightdm-webkit2-greeter xorg-xprop wmctrl papirus-icon-theme volumeicon arandr flameshot pcmanfm   xcb-util-cursor lxappearance  network-manager-applet libnotify  cbatticon notification-daemon zsh zsh-completions keepass nodejs npm vlc smplayer  --noconfirm --needed

sudo echo 'greeter-session=lightdm-webkit2-greeter' >> /etc/lightdm/lightdm.conf

sudo echo "
[D-BUS Service]
Name=org.freedesktop.Notifications
Exec=/usr/lib/notification-daemon-1.0/notification-daemon
" >> /usr/share/dbus-1/services/org.freedesktop.Notifications.service

notify-send Hello



# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting




git clone https://aur.archlinux.org/yay-git.git
sudo chown -R adrian:adrian ./yay-git/
cd yay-git/
makepkg -si

yay -S lightdm-webkit-theme-aether microsoft-edge-stable postman-bin mongodb-bin mongodb-compass    --noconfirm --needed


sudo pacman -S docker --noconfirm --needed
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
sudo docker run hello-world

sudo pacman -Sy docker-compose lsd bat pipewire-pulse pavucontrol --noconfirm --needed


sudo systemctl enable lightdm.service


### Audio
pipewire-pulse &




sudo pacman -Scc

sudo pacman -Rsn $(pacman -Qdtq)