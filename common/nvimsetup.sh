#!/bin/bash
echo 'Setting up ~/.config/nvim/init.vim'
echo ''
mkdir -p ~/.config
mkdir -p ~/.config/nvim
echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
' > ~/.config/nvim/init.vim

mkdir -p ~/.vim

echo 'Installing pathogen'
echo ''
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
echo ''

echo 'Installing plug'
echo ''
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo ' '

