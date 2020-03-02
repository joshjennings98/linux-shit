alias ls='ls --color=auto' # So ls is coloured correctly

batch_rename()
{
	# batch rename all files with the file extension $1
	for f in *.$1; do mv -n "$f" "${f/*/$RANDOM$RANDOM.$1}"; done
}

flash_keyboard()
{

if [ "$1" == "-h" ] || [ "$1" == "--help" ] || ["$1" == ""]

then
	echo " "
	echo "Flash QMK firmware to keyboard."
	echo " "
	echo "usage: flashkb [-i|-f|-h] [src]"
	echo " "
	echo "  -h, --help	 list the help information."
	echo "  -i, --install	 install the dfu programmer."
	echo "  -f, --flash	 flash to at src to keyboard."
	echo " "
fi

if [ "$1" == "-i" ] || [ "$1" == "--install" ]

then
	git clone https://github.com/dfu-programmer/dfu-programmer.git # get the files for the dfu programmer

	cd dfu-programmer       # change to the top-level directory

	# If the source was checked-out from GitHub, run the following command.
	# You may also need to do this if your libusb is in a non-standard location,
	# or if the build fails to find it for some reason.  This command requires
	# that autoconf is installed (sudo apt-get install autoconf)

	./bootstrap.sh          # regenerate base config files

	# Optionally you can add autocompletion using the dfu_completion file,
	# and possibly instructions provided after running the ./bootstrap command

	./configure             # regenerate configure and run it

	# Optionally you can specify where dfu-programmer gets installed
	# using the --prefix= option to the ./configure command.  See
	# ./configure --help for more details.

	# By default the build process will use libusb-1.0 if available.
	# It tries to auto-discover the library, falling back to the older
	# libusb if libusb-1.0 is not available. This process is not entirely
	# reliable and may decide that libusb-1.0 is available when in fact
	# it is not. You can select libusb using --disable-libusb_1_0. If
	# usb library is not available try getting libusb-1.0-0-dev

	make                    # build dfu-programmer

	# Become root if necessary

	make install            # install dfu-programmer
fi

if [ "$1" == "-f" ] || [ "$1" == "--flash" ]

then
	sudo dfu-programmer atmega32u4 erase
	sudo dfu-programmer atmega32u4 flash $2
	sudo dfu-programmer atmega32u4 reset
fi

}

maze()
{
if [ "$1" == "-i" ] 

then 
	cd ~
	git clone https://github.com/joshjennings98/maze-py
	cd maze-py
	python3 maze.py
fi

if [ "$1" == "-r" ]

then
	cd ~/maze-py
	python3 maze.py $2 $3
fi

if [ "$1" == "-h" ]

then
	echo " "
	echo "maze-py"
	echo " "
	echo " -i	Installs maze-py"
	echo " -r	Runs maze-py"
	echo " -h	Shows help information"
	echo " "
fi
}



alias maze='maze' # my shitty maze thing

# Aliases for directories
alias docs='cd ~/Documents/ && ls'
alias down='cd ~/Downloads/ && ls'
alias home='cd ~/ && ls'

# Aliases for commands
alias dual='xrandr --output eDP1 --auto --output HDMI1' # need to check this is right and update if necessary
alias dpidual='xrandr --dpi 180'
alias dpisingle='xrandr --dpi 220'
alias reloadbashrc='source ~/.bashrc' # reload bashrc
alias resetwifi='sudo /etc/init.d/network-manager restart' #reset wifi cause it breaks sometimes
alias p='python3' # python alias
alias pingtest='ping 8.8.8.8 -c 4' # ping
alias ..='cd ..' # cd back one level
alias flashkb='flash_keyboard' # flash keyboard command
alias la='ls -aF' # list all
alias ll='ls -lhFBA' # list all in a list with human readable stuff, extensions, no backup files, and no .. .
alias lr='ls -R' # list EVERYTHING (recursive ls)
alias blset='sudo brightnessctl set' # Set brightness
alias batchrename='batch_rename' # Batch rename file extension (broken)
alias lsalias="grep -in --color -e '^alias\s+*' ~/.bashrc | sed 's/alias //' | grep --colour -e ':[a-z][a-z0-9]*'" # list all aliases





