# .bashrc

alias ffs="firefox -p secure &"
alias fff="firefox -p free &"
alias ffd="firefox -p develop &"
alias chr="google-chrome &"
alias wr="libreoffice --writer &"
alias fm="thunar &"
alias tb="thunderbird &"
alias g="git"
alias gs="git status"
alias ga="git add"
alias gr="git rm"
alias gc="git commit -m"
alias gp="git push -u origin"
alias nodeapp="node ./bin/www"
alias cppapp="./a.out"
alias srto="dnf search"
alias inst="sudo dnf install"
alias del="sudo dnf remove"
alias upd="sudo dnf update"
alias off="shutdown -h now"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
trap 'printf "\e[0m" "$_"' DEBUG
PS1=" \[\033[m\]/\[\033[30;1m\]\w \[\033[m\]> \e[0;36;2m"

setxkbmap -model pc105 -layout pl,ru -option grp:alt_shift_toggle
xkbcomp $DISPLAY - | egrep -v "group . = AltGr;" | xkbcomp - $DISPLAY
tput reset
