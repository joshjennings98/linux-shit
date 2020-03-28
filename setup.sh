# Script for setting my stuff up on a new linux computer

# By Josh Jennings

if [ "$1" == "-h" ] || [ "$1" == "--help" ]

then
	
	echo " "
	echo "Set up a new linux install."
	echo " "
	echo "usage: sudo sh setup.sh [-h|-i] [arch/ubuntu] [surface]"
	echo " "
	echo "  -h, --help	 list the help information."
	echo "  -i, --install	 install programs for [ubuntu|arch] and optionally [surface] patches."
	echo " "

fi

if [ "$1" == "-i" ] || [ "$1" == "--install" ]

then

	if [ "$2" == "ubuntu" ] 

	then
		
		# Install ubuntu packages
		
		# Add ppa stuff and repositories
		sudo apt-get install software-properties-common -y # ppa shit
		sudo add-apt-repository universe -y
		sudo add-apt-repository multiverse -y
		sudo add-apt-repository ppa:unit193/encryption -y # veracrypt ppa
		sudo apt-get update
		sudo apt-get upgrade -y

		# Install python stuff
		sudo apt-get install python3 python3-pip -y
		
		# Install utilities and stuff
		sudo apt-get install apt-transport-https -y
		sudo apt-get install exfat-fuse exfat-utils -y # exfat stuff
		sudo apt-get install git curl wget sed -y
		sudo apt-get install network-manager jq dbus w3m-img ffmpeg scrot xterm alsamixer vim imagemagick fonts-font-awesome snap -y # Prerequisit/Useful Stuff
		sudo apt-get install autoconf autogen libusb-dev -y

		# Install compton stuff
		sudo apt-get install libx11-dev libxcomposite-dev libxdamage-dev libxfixes-dev libxext-dev libxrender-dev libxrandr-dev libxinerama-dev pkg-config make x11proto-core-dev x11-utils libconfig-dev libdrm-dev libgl-dev libdbus-1-3 asciidoc -y
		git clone https://github.com/tryone144/compton ~/
		cd ~/compton
		sudo make
		sudo make docs
		sudo make install
		cd ~/linux-stuff

		# Install i3 stuff
		sudo apt-get install i3 i3status dmenu i3lock xbacklight feh rofi py3status -y
		sudo apt-get install i3-gaps -y
		sudo pip install i3-workspace-names-daemon

		# Install stuff I like to have
		sudo apt-get install vlc firefox htop ranger keepass2 veracrypt rdfind steam pinta ncdu -y # Misc Programs
		sudo apt-get install nmtui blueman brightnessctl -y # QoL programs

		# Install spotify
		curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
		echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
		sudo apt-get update && sudo apt-get install spotify-client -y

		# Install vscode
		curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
		sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
		sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
		sudo apt-get update && sudo apt-get install code -y

		# Install discord
		cd ~/Downloads
		wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
		sudo dpkg -i ~/discord.deb
		cd ~/linux-stuff

		# Install minecraft
		cd ~/Downloads
		wget -o ~/Minecraft.deb https://launcher.mojang.com/download/Minecraft.deb
		sudo dpkg -i ~/Minecraft.deb
		cd ~/linux-stuff

		# Install godot using snap :(
		sudo snap install godot --classic

		if [ "$3" == "surface" ] # Set up kernel patches for surface (ubuntu version)
	
		then
			
			# Add package repositories
			cd ~/Downloads
			wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc \ | sudo apt-key add -
			echo "deb [arch=amd64] https://pkg.surfacelinux.com/debian release main" | sudo tee /etc/apt/sources.list.d/linux-surface.list
			sudo apt-get update && sudo apt-get install linux-headers-surface linux-image-surface linux-libc-dev-surface surface-ipts-firmware linux-surface-secureboot-mok libwacom-surface
			cd ~/linux-stuff

		fi

	fi

	if [ "$2" == "arch" ]

	then
		
		# Install arch packages
		
		# Install yay
		git clone https://aur.archlinux.org/yay.git ~/
		cd ~/yay
		makepkg -si
		cd ~/linux-stuff

		# Install stuff I like to have
		sudo pacman -S py3status --noconfirm

		# Install python stuff
		sudo pacman -S python python-pip --noconfirm
		
		# Install utilities and stuff
		sudo pacman -S exfat-utils --noconfirm # exfat stuff
		sudo pacman -S git curl wget sed --noconfirm
		sudo pacman -S network-manager-applet jq w3m ffmpeg scrot xterm alsa-utils vim imagemagick ttf-font-awesome --noconfirm # Prerequisit/Useful Stuff
		sudo pacman -S autoconf autogen libusb --noconfirm

		# Install compton stuff
		sudo pacman -S libx11 libxcomposite libxdamage libxfixes libxext libxrender libxrandr libxinerama pkgconf make xorgproto xorg-xwininfo xorg-xprop pcre libconfig libdrm glib2 dbus asciidoc --noconfirm
		git clone https://github.com/tryone144/compton ~/
		cd ~/compton
		sudo make
		sudo make docs
		sudo make install
		cd ~/linux-stuff

		# Install i3 stuff
		sudo pacman -S i3 xorg-xbacklight feh rofi py3status --noconfirm
		sudo pip install i3-workspace-names-daemon

		# Install stuff I like to have
		sudo pacman -S vlc firefox htop ranger keepass veracrypt steam pinta ncdu -y # Misc Programs
		sudo pacman -S blueman brightnessctl -y # QoL programs

		# Install vscode
		sudo pacman -S code

		# Install discord
		sudo pacman -S discord

		# Install AUR stuff
		yay -S rdfind spotify minecraft-launcher godot

		if [ "$3" == "surface" ] # Set up kernel patches for surface (arch version)

		then
			
			# Add package repositories
			cd ~/Downloads
			wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc \ | sudo pacman-key --add -
			sudo pacman-key --finger 56C464BAAC421453
			sudo pacman-key --lsign-key 56C464BAAC421453
			echo '[linux-surface]' >> /etc/pacman.conf
			echo 'Server = https://pkg.surfacelinux.com/arch/' >> /etc/pacman.conf
			sudo pacman -S linux-surface-headers linux-surface surface-ipts-firmware linux-surface-secureboot-mok			
			cd ~/linux-shit

		fi

	fi

	# Install non distro specific packages

	# Install JDownloader2
	cd ~/Downloads
	wget http://installer.jdownloader.org/JD2SilentSetup_x64.sh
	chmod +x JD2SilentSetup_x64.sh
	./JD2SilentSetup_x64.sh
	cd ~/linux-shit

	# Move all the configuration files to the correct places

	# Create system files
	cp -f system\ stuff/.bashrc ~/
	source ~/.bashrc
	cp -f system\ stuff/.Xresources ~/
	cp -f system\ stuff/compton.conf /etc/xdg/

	# Move ranger stuff
	mkdir ~/.config/ranger
	cp -f ranger/rc.conf ~/.config/ranger/
	cp -f ranger/rifle.conf ~/.config/ranger/
	cp -f ranger/scope.sh ~/.config/ranger/

	# Move i3 stuff
	mkdir ~/.config/i3
	cp -f i3/i3status.conf ~/.config/i3/
	cp -f i3/config ~/.config/i3/
	cp -f i3/app-icons.json ~/.config/i3/

	# Move rofi config
	mkdir ~/rofi
	cp -f rofi/rofi_config.rasi ~/rofi/

	# Set up wallpapers
	mkdir ~/wallpapers
	cp -f wallpapers/nebula.jpg ~/wallpapers/

	# Set up vscode
	codeextensions -l vscode/vscodeextensions.txt
	cp -f vscode/vscode\ settings.json ~/.config/Code/User/
	mv ~/.config/Code/User/vscode\ settings.json ~/.config/Code/User/settings.json

	# Make scripts executable
	chmod +x ~/linux-stuff/scripts/flashkb.sh
	chmod +x ~/linux-stuff/scripts/codeextensions.sh
	chmod +x ~/linux-stuff/scripts/swapscreens.sh

fi

# Reload .bashrc and stuff
source ~/.bashrc
xrdb ~/.Xresources

# Warning about surface-linux post install stuff
if [ "$3" == "surface" ]

then
	echo " "
	echo "NOTES:"
	echo "- NEED TO CHECK IF BOOTLOADER HAS BOOTED INTO THE CORECT KERNEL SINCE USING SURFACE-LINUX"
	echo "- MIGHT NEED TO LOOK AT POST INSTALL STUFF HERE FOR SURFACE-LINUX https://github.com/linux-surface/linux-surface/wiki/Installation-and-Setup"
	echo " "
fi

# Reboot
echo "Everything should be installed."
read -r -p "Would you like to reboot now? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    reboot
else
    echo "Remember to reboot soon to apply changes."
fi
