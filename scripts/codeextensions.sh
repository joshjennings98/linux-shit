if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$#" -ne 2 ]

then
	echo " "
	echo "Save and load Visual Studio Code extensions."
	echo " "
	echo "usage: codeextensions [-s|-l|-h] [src/dst]"
	echo " "
	echo "  -h, --help	 list the help information."
	echo "  -s, --save	 save vscode extensions to [dst]."
	echo "  -l, --load	 install vscode extensions from [src]"
	echo " "
fi

if [ "$1" == "-s" ] || [ "$1" == "--save" ] && [ "$#" -eq 2 ]

then
	rm $2
	code --list-extensions >> $2
	echo "Saved list of vscode extensions to $2."
fi

if [ "$1" == "-l" ] || [ "$1" == "--load" ] && [ "$#" -eq 2 ]

then
	cat $2 | xargs -n 1 code --install-extension
	echo " "
	echo "Installed all vscode extensions specified in $2."
fi
