# Stuff for setting up a new linux system

# To Do: Need to add stuff for setting up Visual Studio Code extensions (and vim?), add more packages as necessary

# Move .bashrc
mv -f .bashrc ~/

# Install stuff I like to have:
#
# cool-retro-term
# jakeday surface kernel patch (if using surface)
# vlc
# vscode
# monodevelop
# jdownloader2
# firefox
# youtube-dl

if [ "$1" == "ubuntu" ]
then
	sudo apt-get update	
	sudo apt-get install software-properties-common -y
	
	# cool-retro-term ppa
	sudo add-apt-repository ppa:noobslab/apps
	
	# MonoDevelop setup
	sudo apt install apt-transport-https dirmngr -y
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb https://download.mono-project.com/repo/ubuntu vs-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-vs.list
	sudo apt update
	
	# Install everything
	sudo apt-get install ffmpeg
	sudo apt-get install cool-retro-term vlc code firefox youtube-dl monodevelop -y 
fi

if [ "$1" == "arch" ]
then
	sudo pacman -Syu

	# Install everything
	sudo pacman -S ffmpeg	
	sudo pacman -S cool-retro-term vlc code firefox youtube-dl

	echo "MonoDevelop not set up for Arch Linux yet."
fi

if [ "$1" == "ubuntu" ] & [ "$2" == "surface" ]
then
	# Set up Jakeday kernel patch for surface	
	sudo apt install git curl wget sed
	git clone --depth 1 https://github.com/jakeday/linux-surface.git ~/linux-surface
	cd ~/linux-surface
	sudo sh setup.sh
fi

if [ "$1" == "arch" ] & [ "$2" == "surface" ]
then
	echo "Jakeday patches not set up for Arch Linux yet."
fi

# JDownloader2 setup
cd ~/Downloads
wget http://installer.jdownloader.org/JD2SilentSetup_x64.sh
chmod +x JD2SilentSetup_x64.sh
./JD2SilentSetup_x64.sh
cd ~/
# Reload .bashrc at end because it breaks the first time you run cd
source ~/.bashrc

# Reboot the system
reboot
	
