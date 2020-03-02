# Stuff for setting up a new linux system

# To Do: Need to add stuff for setting up Visual Studio Code extensions

# Move .bashrc and .Xresources
cp -i .bashrc ~/
cp -i .Xresources ~/

# Move i3 stuff
mkdir ~/.config/i3
cp -i i3status.conf ~/.config/i3/
cp -i i3config ~/.config/i3/

# Move spotify bar stuff
cp -i ~/i3spotifystatus ~/

# Set up wallpapers
mkdir ~/wallpapers
cp -i /wallpapers/amberchronicles.jpg ~/wallpapers/
cp -i /wallpapers/wayofkings.jpg ~/wallpapers/

# Stuff for surface
if [ "$1" == "surface" ]
then
	# Set up Jakeday kernel patch for surface	
	sudo apt install git curl wget sed
	git clone --depth 1 https://github.com/jakeday/linux-surface.git ~/linux-surface
	cd ~/linux-surface
	sudo sh setup.sh
fi

# Install useful prerequisite stuff
sudo apt-get update	
sudo apt-get upgrade
sudo add-apt-repository universe
sudo apt-get update
sudo apt install exfat-fuse exfat-utils -y # exfat stuff
sudo apt-get install software-properties-common -y # ppa shit
sudo apt-get install apt-transport-https -y
sudo atp-get update

# veracrypt stuff
sudo add-apt-repository ppa:unit193/encryption # veracrypt ppa
sudo apt-get update

# Replace this with something better
# Install F# dev stuff (remember to do load project first in monodevelop to fix packages (or work out a way to restore packages using vscode)) 
# sudo apt install apt-transport-https dirmngr -y # monodevelop part 1 (need monodevelop to restore files)
# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF # monodevelop part 2
# echo "deb https://download.mono-project.com/repo/ubuntu vs-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-vs.list # monodevelop part 3
# sudo apt update
# wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb #.Net Stuff part 1
# sudo dpkg -i packages-microsoft-prod.deb #.Net Stuff part 2
# sudo apt-get install dotnet-sdk-3.1 -y #.Net Stuff part 3
# sudo apt install fsharp -y # F# Stuff
# sudo apt install monodevelop -y # Need monodevelop

# Install i3 stuff
sudo apt install i3 i3status dmenu i3lock xbacklight feh conky rofi -y
xrandr --dpi 180 # Set up dpi scaling for i3

# Install stuff I like to have
sudo apt-get install network-manager ffmpeg scrot xterm alsamixer vim imagemagick fonts-font-awesome snap -y # Prerequisit/Useful Stuff
sudo apt-get install vlc firefox youtube-dl htop ranger keepass2 veracrypt rdfind pinta ncdu -y # Misc Programs
sudo apt-get install nmtui blueman brightnessctl -y # QoL programs
# sudo apt-get install vagrant virtualbox -y # fyp stuff
snap install code --classic # vscode requires snap

# Install JDownloader2
cd ~/Downloads
wget http://installer.jdownloader.org/JD2SilentSetup_x64.sh
chmod +x JD2SilentSetup_x64.sh
./JD2SilentSetup_x64.sh
cd ~/

# Set up fallout grub (NOTE, MOVE REPO TO MY GITHUB AND CHECK FOR VIRUSES ETC.)
# wget -O - https://github.com/shvchk/fallout-grub-theme/raw/master/install.sh | bash 

# Reload .bashrc and stuff
source ~/.bashrc
xrdb ~/.Xresources

# Reboot the system
echo "Rebooting the system."
reboot
