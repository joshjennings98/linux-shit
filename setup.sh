# Stuff for setting up a new linux system

# To Do: Need to add stuff for setting up Visual Studio Code extensions

# To install: vim, alsamixer

# Move .bashrc and stuff
mv -f .bashrc ~/
# need to move wallpapers
# need to move i3status
# need to move .Xresources
# need to move (and reaload) i3config	

# need to install .net sdk

if [ "$1" == "surface" ]
then
	# Set up Jakeday kernel patch for surface	
	sudo apt install git curl wget sed
	git clone --depth 1 https://github.com/jakeday/linux-surface.git ~/linux-surface
	cd ~/linux-surface
	sudo sh setup.sh
fi

# Install stuff for using ppas
sudo apt-get update	
sudo apt-get install software-properties-common -y # ppa shit

# cool-retro-term ppa
sudo add-apt-repository ppa:vantuz/cool-retro-term

# MonoDevelop setup
sudo apt install apt-transport-https dirmngr -y
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu vs-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-vs.list
sudo apt update

# Install stuff I like to have
sudo apt-get install ffmpeg scrot
sudo apt-get install cool-retro-term vlc code firefox youtube-dl monodevelop htop -y 
snap install code --install

# Install i3 stuff
sudo apt install i3 i3status dmenu i3lock xbacklight feh conky
xrandr --dpi 180 # Set up dpi scaling for i3

# JDownloader2 setup
cd ~/Downloads
wget http://installer.jdownloader.org/JD2SilentSetup_x64.sh
chmod +x JD2SilentSetup_x64.sh
./JD2SilentSetup_x64.sh
cd ~/

# Set up fallout grub (NOTE, MOVE REPO TO MY GITHUB AND CHECK FOR VIRUSES ETC.)
wget -O - https://github.com/shvchk/fallout-grub-theme/raw/master/install.sh | bash 

# Reload .bashrc at end because it breaks the first time you run cd
source ~/.bashrc

# Reboot the system
reboot
	
