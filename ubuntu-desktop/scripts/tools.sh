#!/usr/bin/env bash
set -eux
export DEBIAN_FRONTEND=noninteractive
HOME="/home/ubuntu"

## do sth like if ENVIRONMENT ID == bar then gnome else i3 

if [ ${desktop_env} == "i3" ]; then
echo "setting up i3 desktop"
	apt install -y i3 i3lock pavucontrol gnome-clocks thunar thunar-archive-plugin rofi xsettingsd scrot feh compton lightdm lightdm-gtk-greeter alsa pulseaudio pavucontrol pnmixer qpdfview thunderbird git
	apt install -y --no-install-recommends network-manager-gnome network-manager-openvpn-gnome 
	apt install -y --install-suggests lxappearance
	apt remove -y --purge byobu 
	snap install alacritty --classic
else
	echo "setting up gnome desktop" 
	apt install --no-install-recommends -y ubuntu-desktop-minimal nautilus fonts-noto gnome-shell-extension-no-annoyance gnome-shell-extension-impatience gnome-shell-extension-caffeine gnome-tweaks 
	apt remove -y --purge gnome-shell-extension-ubuntu-dock
fi

if [ $guest_additions_mode == "disable" ]; then
    apt install -y virtualbox-guest-dkms virtualbox-guest-x11 virtualbox-guest-utils
fi
#basic packages
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list
apt update -y
apt install -y atom zsh zsh-syntax-highlighting zsh-autosuggestions curl firefox ffmpeg gocryptfs apt-transport-https python3-pip whois ghostwriter
sudo -H -u ubuntu pip install  ipykernel jedi==0.17.2
sudo -H -u ubuntu python3 -m ipykernel install --user
# my dotfiles
chown -R ubuntu:ubuntu $HOME
git clone https://github.com/IamLunchbox/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles && ./install
cd ..

echo "ubuntu" | chsh -s /usr/bin/zsh ubuntu
echo "ubuntu" | localectl set-keymap de

systemctl set-default graphical.target

usermod -a -G vboxsf ubuntu

timedatectl set-timezone "Europe/Berlin"
chown -R ubuntu:ubuntu $HOME
