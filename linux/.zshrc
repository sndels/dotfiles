# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="agnoster"

# Hide username@hostname
export DEFAULT_USER=$USER

plugins=(git)

# User configuration
setxkbmap -layout us,fi -option 'grp:lalt_lshift_toggle'

alias nvim=vim
alias clangmake='CXX=clang++ CC=clang cmake'

export PATH="$PATH"

source $ZSH/oh-my-zsh.sh
