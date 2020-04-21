alias ls='ls --color=auto' # So ls is coloured correctly

# Aliases for directories
alias docs='cd ~/Documents/ && ls'
alias down='cd ~/Downloads/ && ls'
alias home='cd ~/ && ls'
alias ..='cd ..' # cd back one level

# Aliases for commands
alias dual='xrandr --output HDMI-1 --auto --right-of eDP1' # need to check this is right and update if necessary
alias dpidual='xrandr --dpi 180' # set dpi for surface and 1080p monitor
alias dpisingle='xrandr --dpi 220' # set dpi for surface only
alias reloadbashrc='source ~/.bashrc' # reload bashrc
alias resetwifi='sudo /etc/init.d/network-manager restart' #reset wifi cause it breaks sometimes
alias p='python3' # python alias
alias pingtest='ping 8.8.8.8 -c 4' # ping
alias flashkb='~/linux-shit/scripts/flashkb.sh' # flash keyboard command
alias la='ls -aF' # list all
alias ll='ls -lhFBA' # list all in a list with human readable stuff, extensions, no backup files, and no .. .
alias lr='ls -R' # list EVERYTHING (recursive ls)
alias blset='sudo brightnessctl set' # Set brightness
alias codeextensions='~/linux-shit/scripts/codeextensions.sh'
alias lsalias="grep -in --color -e '^alias\s+*' ~/.bashrc | sed 's/alias //' | grep --colour -e ':[a-z][a-z0-9]*'" # list all aliases"
alias linecount="git ls-files | xargs wc -l" # Count lines of code in git repo
