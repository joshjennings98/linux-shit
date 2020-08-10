#!/usr/bin/env bash

installCommand="sudo apt-get install -y"
checkIfInstalled="dpkg-query -l"
notInstalledMessage="no packages found"
altInstallCommand="sudo apt-get install -y"

# Check valid inputs
if [ "$#" -ne 1 ] ; then
    echo "Invalid number of arguments, a file must be provided."
    exit 1
elif ! [ -f "$1" ]; then
    echo "The file '$1' does not exist."
    exit 1
fi

# Read packages from file to $packages
readarray -t packages < $1 # -t will strip newlines

{   
# Set up arrays to track installed stuff 
done=()
notInstalled=()
stillNotInstalled=()
 
# Attempt to install each package and then check whether it was installed
for package in ${packages[@]}
do
    $installCommand $package

    # Check whether package installed
    if echo $($checkIfInstalled $package 2>&1) | grep -q "$notInstalledMessage" ; then
        notInstalled+=( $package )
    else
        done+=( $package )
    fi
done

# Try alternate install for packages not installed
for package in ${notInstalled[@]}
do
    $altInstallCommand $package
    
    # Check whether package installed
    if echo $($checkIfInstalled $package 2>&1) | grep -q "$notInstalledMessage" ; then
        stillNotInstalled+=( $package )
    else
        done+=( $package )
    fi
done

} &> /dev/null # Don't print output from this section

{
echo "Installed the following packages:"
 
for item in ${done[@]}
do
    echo "  $item"
done

echo "Failed to install the following packages:"
 
for item in ${stillNotInstalled[@]}
do
    echo "  $item"
done
} | tee install-log.txt # Save output to log file
