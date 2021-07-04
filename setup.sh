#!/bin/bash

# Josh's setup script
# 
# Currently supports:
# - Ubuntu

PACKAGES_APT=(
    "nvidia-driver-465" # may need to update
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
    "libxinerama-dev"
    "libxft-dev"
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
    "w3m" # for ranger
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

sudo apt-get update
sudo apt-get upgrade -y

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

# build and install slock
cp -r ~/linux-stuff/Applications/slock ~
cd ~/slock
sudo make clean install
rm -rf ~/slock

# build and install dmenu
cp -r ~/linux-stuff/Applications/dmenu ~
cd ~/dmenu
sudo make clean install
rm -rf ~/dmenu

# build and install st
cp -r ~/linux-stuff/Applications/st ~
cd ~/st
sudo make install
rm -rf ~/st

# build and install clipmenud and clipnotify
cp -r ~/linux-stuff/Applications/clipnotify ~
cd ~/clipnotify
sudo make install
cp -r ~/linux-stuff/Applications/clipmenu ~
cd ~/clipmenu
sudo make install
rm -rf ~/clipnotify
rm -rf ~/clipmenu

# install lutris
sudo add-apt-repository -y ppa:lutris-team/lutris
sudo apt update
sudo apt install -y lutris

# install and setup vscode
cd ~
curl -L -o vscode.deb "https://go.microsoft.com/fwlink/?LinkID=760868"
sudo apt install -y ./vscode.deb
rm vscode.deb
mkdir -p ~/.config/Code/User
cp -r ~/linux-stuff/Applications/vscode/snippets ~/.config/Code/User
cp -r ~/linux-stuff/Applications/vscode/settings.json ~/.config/Code/User
~/Scripts/codeextensions.sh -l ~/linux-stuff/Applications/vscode/vscodeextensions.txt

# install discord
cd ~
curl -L -o discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo apt install -y ./discord.deb
rm discord.deb

# install spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install -y spotify-client

# install minecraft
cd ~
curl -L -o minecraft.deb https://launcher.mojang.com/download/Minecraft.deb
sudo apt install -y ./minecraft.deb
rm minecraft.deb

# install golang (may need to update version)
cd ~
curl -L -o go.tar.gz https://golang.org/dl/go1.16.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go.tar.gz
export PATH=$PATH:/usr/local/go/bin

# setup fonts
mkdir -p ~/.local/share/fonts 
cp ~/linux-stuff/iosevka_regular.ttf ~/.local/share/fonts
fc-cache -f -v

# reboot pc (optional)
read -p "Would you like to reboot? (Note: you still need to setup firefox (tablis wallpaper etc.), lutris stuff (including epic games store and origin), and probably update nvidia drivers." -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    reboot
fi

