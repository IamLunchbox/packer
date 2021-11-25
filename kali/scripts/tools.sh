#!/usr/bin/bash
set -eux

HOME="/home/kali"
# This script installs a bunch of tools that are commonly used on Penetration Tests.
export DEBIAN_FRONTEND=noninteractive
kernel_install="linux-image-amd64"
kernel_headers="linux-headers-amd64"
apt-get update -y
# from bento project
apt-get -y upgrade -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confnew' "${kernel_install}"
apt-get -y install "${kernel_headers}"
apt-get upgrade -y -o Dpkg::Options::='--force-confnew'
apt-get dist-upgrade -y -o Dpkg::Options::='--force-confnew'
apt-get autoremove -y -o Dpkg::Options::='--force-confnew'


# Setup folders

# Install common tools

if [[ ${desktop_env} == "i3" ]]; then
echo "setting up i3 desktop"
	apt install -y i3 i3lock hsetroot rofi xsettingsd scrot compton lightdm lightdm-gtk-greeter alsa pulseaudio pavucontrol pnmixer qpdfview thunderbird git feh gnome-clocks
	apt install -y --no-install-recommends network-manager-openvpn-gnome network-manager-gnome
fi

apt-get install -y --no-install-recommends whois gocryptfs python3-requests python3-pymssql xxd python3-pexpect python3-pefile python3-openssl python3-pip tcpdump python3-virtualenv gobuster ufw remmina jython remmina-plugin-rdp seclists

ufw allow 22
ufw enable

mkdir -p /home/kali/Desktop && cd /home/kali/Desktop
wget -O burpsuite-install.sh 'https://portswigger.net/burp/releases/download?product=pro&version=2021.9.1&type=Linux'
mkdir -p /home/kali/Documents
chmod +x /home/kali/Desktop/burpsuite-install.sh
chown -R kali:kali $HOME

wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list
apt update -y
apt install -y atom 
sudo -H -u kali pip install  ipykernel jedi==0.17.2
sudo -H -u kali python3 -m ipykernel install --user

chown -R kali:kali $HOME
git clone https://github.com/IamLunchbox/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles && ./install
cd ..

echo "kali" | localectl set-keymap de

systemctl set-default graphical.target

usermod -a -G vboxsf,kali-trusted kali

timedatectl set-timezone "Europe/Berlin"

cd $HOME/Repos && git clone https://github.com/swisskyrepo/PayloadsAllTheThings 

chown -R kali:kali $HOME
