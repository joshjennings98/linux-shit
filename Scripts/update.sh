#!/bin/bash

sudo -p "Updating APT packages. Please type password: " apt upgrade -y
i3-msg restart &

