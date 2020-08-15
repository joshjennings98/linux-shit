# Josh's Linux Stuff

This repo contains my useful linux stuff like my `.bashrc` and other scripts/config files. It also contains an install script for setting up new computers with the stuff I like to have.

## Install Script Usage

### Pre-requisites:

There are several prerequisites for this script:
* Python 3
* Bash

### Usage

To set up a new linux computer, adjust the packages and commands and stuff in `main()` of `setup.py`, then run the following:

```bash
cd ~
git clone https://github.com/joshjennings98/linux-stuff
python3 linux-stuff/setup.py
```

