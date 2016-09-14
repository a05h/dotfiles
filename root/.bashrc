# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

cd /
trap 'printf "\e[0m" "$_"' DEBUG
PS1=" \[\033[31;1m\]root \[\033[30;1m\]\w \[\033[m\]> \e[0;31;1m"