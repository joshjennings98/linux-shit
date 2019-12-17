# Stuff for setting up a new linux system

# To Do: Need to add stuff for setting up Visual Studio Code extensions

# Move .bashrc and stuff
mv -f .bashrc ~/
mv -f .Xresources ~/
mkdir ~/.config/i3
mv -f i3status.conf ~/.config/i3/
mv -f i3config ~/.config/i3/
mkdir ~/wallpapers
mv /wallpapers/amberchronicles.jpg ~/wallpapers/
# need to move (and reaload) i3config	

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

# cool-retro-term ppa (not at moment)
# sudo add-apt-repository ppa:vantuz/cool-retro-term
# sudo apt install cool-retro-term 

# MonoDevelop setup
sudo apt install apt-transport-https dirmngr -y
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu vs-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-vs.list
sudo apt update

# Install F# stuff (remember to do `restore packages` in vscode) 
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install dotnet-sdk-3.1

sudo apt install fsharp

# Install i3 stuff
sudo apt install i3 i3status dmenu i3lock xbacklight feh conky -y
xrandr --dpi 180 # Set up dpi scaling for i3

# Install stuff I like to have
sudo apt-get install ffmpeg scrot rxvt-unicode -y
sudo apt-get install vlc firefox youtube-dl htop ranger alsamixer vim -y # Might need to add monodevelop
snap install code --install

# JDownloader2 setup
cd ~/Downloads
wget http://installer.jdownloader.org/JD2SilentSetup_x64.sh
chmod +x JD2SilentSetup_x64.sh
./JD2SilentSetup_x64.sh
cd ~/

# Set up fallout grub (NOTE, MOVE REPO TO MY GITHUB AND CHECK FOR VIRUSES ETC.)
wget -O - https://github.com/shvchk/fallout-grub-theme/raw/master/install.sh | bash 

# Reload .bashrc and stuff
source ~/.bashrc
xrdb ~/.Xresources

# Reboot the system
reboot
	
