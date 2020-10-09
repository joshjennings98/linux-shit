X="test"
for FILE in $(ls -d /usr/share/applications/*)
do
	Y1=$(grep '^Exec' $FILE | tail -1 | sed 's/^Exec=//' | sed 's/%.//' | sed 's/^"//g' | sed 's/" *$//g')
	Y2=${FILE%.desktop}
	Y2=${Y2##*/}
	X="$X\n$Y1"
done


#y=${x%.bar}
#$ echo ${y##*/}

echo $X | dmenu | "/bin/sh"
