#!/usr/bin/env bash

# Check valid inputs
if [ "$#" -ne 1 ] ; then
    echo "Invalid number of arguments, a config file must be provided."
    exit 1
elif ! [ -f "$1" ]; then
    echo "The file '$1' does not exist."
    exit 1
fi   

declare -A commands

# Set up arrays to track installed stuff 
packages=()
done=()
notInstalled=()
stillNotInstalled=()
packagesFlag=0

# Shitty if else thing for parsing config file
{
    {
        while read
        do 
           if echo "$REPLY" | grep -P "#.*?" ; then
                echo "Comment: $REPLY"
           elif [ "$packagesFlag" -eq 1 ] ; then # Install packages        
               if echo "$REPLY" | grep "=" ; then
                   key=${REPLY%% = *}
                   value=${REPLY#* = }
                   commands[$key]=$value
                   packagesFlag=0
               else
                   packages+=( ${REPLY#* } )
               fi
           # Create commands 
           elif echo "$REPLY" | grep -P "packages = .*?" ; then
               packagesFlag=1
               packages+=( ${REPLY#* = } )
           elif echo "$REPLY" | grep -P "packages = " ; then
               packagesFlag=1
           elif echo "$REPLY" | grep -P ".*?( = ).*?" ; then
               key=${REPLY%% = *}
               value=${REPLY#* = }
               commands[$key]=$value
               packagesFlag=0
           fi
           
        done
    } < $1   

    # Set commands
    installCommand="${commands[install-command]}"
    checkIfInstalled="${commands[check-installed]}"
    notInstalledMessage="${commands[install-failure-string]}"
    altInstallCommand="${commands[alt-install-command]}" 
     
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

} &> /dev/null # Don't print output from this section (for debug comment out the &>)

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
