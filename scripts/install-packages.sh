#!/usr/bin/env bash

# List of packages to install
packages=(
    "vim"
    "vlc"
    "popasdapsdadas" # test fake package
    )

# Set commands required for install stuff
installcommand="sudo apt-get install -y"
checkinstall="dpkg-query -l"
notinstalledmessage="no packages found"
altInstallCommand="sudo apt-get install -y"

# Install section
{   
# Set up arrays to track installed stuff 
done=()
notinstalled=()
 
# Attempt to install each package and then check whether it was installed
for package in ${packages[@]}
do
    # Install package
    $installcommand $package

    # Check whether package installed
    if echo $($checkinstall $package 2>&1) | grep -q "$notinstalledmessage" ; then
        notinstalled+=( $package )
    else
        done+=( $package )
    fi
done

# Do stuff for packages that weren't installed normal way
stillnotinstalled=()

for package in ${notinstalled[@]}
do
    $altInstallCommand $package
    
    # Check whether package installed
    if echo $($checkinstall $package 2>&1) | grep -q "$notinstalledmessage" ; then
        stillnotinstalled+=( $package )
    else
        done+=( $package )
    fi
done

} &> /dev/null # Don't print output from this section

# Results section
{
# List installed packages
echo "Installed the following packages:"
 
for item in ${done[@]}
do
    echo "  $item"
done

# List non-installed packages
echo "Failed to install the following packages:"
 
for item in ${stillnotinstalled[@]}
do
    echo "  $item"
done
} | tee install-log.txt # Save output to log file
