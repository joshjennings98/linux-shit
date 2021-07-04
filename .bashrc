### Josh's .bashrc

### Aliases for directories

alias docs='cd ~/Documents/ && ls'       # goto documents folder
alias down='cd ~/Downloads/ && ls'       # goto downloads folder
alias home='cd ~/ && ls'                 # goto home directory
alias ..='cd ..'                         # go up a directoy

### Aliases for listing files (ls)

alias ls='ls --color=auto'              # make sure ls is coloured correctly
alias la='ls -aF'                       # list all
alias ll='ls -lhFBA'                    # list all in a list with human readable stuff, extensions, no backup files, and no .. .
alias lr='ls -R'                        # list EVERYTHING (recursive ls)

### Aliases for commands

alias p='python3'                       # python alias
alias blset='sudo brightnessctl set'    # set brightness
alias lsalias="grep -in --color -e '^alias\s+*' ~/.bashrc | sed 's/alias //' | grep --colour -e ':[a-z][a-z0-9]*'"            # list all aliases"
alias lspackages="comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)"
alias linecount="git ls-files | xargs wc -l" # count lines of code in git repo
alias reloadbashrc='source ~/.bashrc'   # reload bashrc
alias resetwifi='sudo /etc/init.d/network-manager restart' # reset wifi cause it breaks sometimes

### PATH exports
export PATH=$PATH:/usr/local/go/bin
