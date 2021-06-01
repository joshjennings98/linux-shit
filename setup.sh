#!/bin/bash

# Josh's setup script
# 
# Currently supports:
# - Ubuntu

PACKAGES_APT=( # need to work out the packages needed to build stuff later as well as other missing ones
    "i3"
    "ffmpeg"
    "apt-transport-https"
    "exfat-utils"
    "libxrandr-dev"
    "libimlib2-dev"
    "python3"
    "python3-pip"
    "firefox"
    "git"
    "vim"
    "htop"
    "feh"
    "pavucontrol"
    "dxvk"
    "nautilus"
    "pinta"
    "maim"
    "jq"
    "ncdu"
    "blueman"
    "network-manager"
    "py3status"
    "steam"
    "lm-sensors"
    "ranger"
    "curl"
    "mpv"
    "thunar"
    "w3m" # for ranger (might need ueberzug from pip3?)
    "xsel"
    "build-essential"
    "libx11-dev"
    "libxtst-dev"
    "vlc"
)

PACKAGES_PIP=(
    "i3ipc"   
    "youtube-dl"
)

# install apt packages
sudo apt install -y "${PACKAGES_APT[@]}"

# install necessary pip packages
pip3 install "${PACKAGES_PIP[@]}"

# copy system stuff
cp -r ~/linux-stuff/Wallpapers ~
cp -r ~/linux-stuff/Scripts ~
cp -r ~/linux-stuff/Applications/i3 ~/.config/i3
cp -r ~/linux-stuff/Applications/ranger/ ~/.config/
cp ~/linux-stuff/Applications/vim/.vimrc ~
cp ~/linux-stuff/.bashrc ~
cp ~/linux-stuff/.inputrc ~

# setup slock
cp -r ~/linux-stuff/Applications/slock ~
cd ~/slock
sudo make clean install

# setup lutris
sudo add-apt-repository -y ppa:lutris-team/lutris
sudo apt update
sudo apt install -y lutris

# setup dmenu
cp -r ~/linux-stuff/Applications/dmenu ~
cd ~/dmenu
sudo make clean install

# setup clipmenud/clipnotify
cp -r ~/linux-stuff/Applications/clipnotify ~
cd ~/clipnotify
sudo make clean install
cp -r ~/linux-stuff/Applications/clipmenu ~
cd ~/clipmenu
sudo make clean install

# setup vscode
cd ~
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb
sudo apt install vscode.deb
rm vscode.deb
cp -r ~/linux-stuff/Applications/vscode/snippets ~/.config/Code/User
cp -r ~/linux-stuff/Applications/vscode/settings.json ~/.config/Code/User
~/Scripts/codeextensions.sh -l ~/linux-stuff/Applications/vscode/vscodeextensions.txt

# setup discord
cd ~
wget https://discord.com/api/download?platform=linux&format=deb -O discord.deb
sudo apt install discord.deb
rm discord.deb

# setup spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

# reboot pc (optional)
read -p "Would you like to reboot? (Note: you still need to setup firefox (tablis wallpaper etc.) and probably nvidia drivers." -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo reboot
fi

