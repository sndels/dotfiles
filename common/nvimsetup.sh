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
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
echo ' '

echo 'Installing the theme'
echo ''
git clone https://github.com/tomasiser/vim-code-dark ~/.vim/bundle/vim-code-dark
echo ''

echo 'Installing vim-airline'
echo ''
git clone --branch v0.10 --depth=1 https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone --depth=1 https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
echo ''
echo ''
