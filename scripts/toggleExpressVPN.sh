#!/bin/bash

if [[ $(expressvpn status) == *"Connected"* ]] ; then 
    expressvpn disconnect ; 
else 
    expressvpn connect ; 
fi
