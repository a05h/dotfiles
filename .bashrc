# .bashrc

alias ffs="firefox -p secure &"
alias fff="firefox -p free &"
alias ffd="firefox -p develop &"
alias chrome="google-chrome &"
alias writer="libreoffice --writer &"
alias thunar="thunar &"
alias tb="thunderbird &"
alias g="git"
alias gs="git status"
alias ga="git add"
alias gr="git rm"
alias gc="git commit -m"
alias gp="git push -u origin"
alias nodeapp="node ./bin/www"
alias cppapp="./a.out"
alias ?repo="dnf search"
alias ?find="find . -type f -name"
alias install="sudo dnf install"
alias delete="sudo dnf remove"
alias update="sudo dnf update"
alias off="shutdown -h now"

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

trap 'printf "\e[0m" "$_"' DEBUG
PS1=" \[\033[m\]/\[\033[30;1m\]\w \[\033[m\]> \e[0;34;1m"

setxkbmap -model pc105 -layout pl,ru -option grp:alt_shift_toggle
xkbcomp $DISPLAY - | egrep -v "group . = AltGr;" | xkbcomp - $DISPLAY
tput reset
cd /
