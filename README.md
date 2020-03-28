# My Useful Linux Stuff

This repo contains my useful linux stuff like my `.bashrc` and other scripts/config files. It also contains an install script for setting up new computers with the stuff I like to have.

## Install Script Usage

To set up a new linux computer run:
```bash
git clone https://github.com/joshjennings98/linux-stuff
cd linux-stuff
sh setup.sh [flag] [distro] [surface]
```
* **Flags:** `-i` for install, `-h` for help.
* **Distro:** `arch` for Arch Linux, `ubuntu` for Ubuntu.
* **Surface:** `surface` to install `linux-surface` kernel patches, leave black if not needed.
