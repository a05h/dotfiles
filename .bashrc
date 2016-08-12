# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
trap 'printf "\e[0m" "$_"' DEBUG
PS1=" \[\033[m\]/\[\033[30;1m\]\w \[\033[m\]> \e[0;36;2m"

setxkbmap -model pc105 -layout pl,ru -option grp:alt_shift_toggle
xkbcomp $DISPLAY - | egrep -v "group . = AltGr;" | xkbcomp - $DISPLAY
tput reset
