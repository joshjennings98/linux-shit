if [ "$1" == "-h" ] || [ "$1" == "--help" ] 

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

if [ "$1" == "-i" ] || [ "$1" == "--install" ] && [ "$#" -eq 1 ]

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

	sudo make                    # build dfu-programmer

	# Become root if necessary

	sudo make install            # install dfu-programmer
fi

if [ "$1" == "-f" ] || [ "$1" == "--flash" ] && [ "$#" -eq 2 ]

then
	sudo dfu-programmer atmega32u4 erase
	sudo dfu-programmer atmega32u4 flash $2
	sudo dfu-programmer atmega32u4 reset
fi
