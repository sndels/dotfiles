#!/bin/bash
echo 'Symlinking ~/.vimrc to ~/.vim/init.vim'
mkdir ~/.vim
ln -s ~/.vimrc ~/.vim/init.vim
echo ''

echo 'Installing pathogen'
mkdir ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
echo ''

echo 'Installing NERDtree'
git clone --depth=1 https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
echo ''

echo 'Installing vim-airline'
git clone --depth=1 https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone --depth=1 https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
echo ''

echo 'Installing rust.vim'
git clone --depth=1 https://github.com/rust-lang/rust.vim.git ~/.vim/bundle/rust.vim
echo ''

echo 'Installing LanguageClient-neovim'
git clone --depth=1 https://github.com/autozimu/LanguageClient-neovim.git ~/.vim/bundle/LanguageClient-neovim
cd ~/.vim/bundle/LanguageClient-neovim
./install.sh
cd
echo ''

echo 'Installing deoplete'
pip3 install neovim
git clone --depth=1 https://github.com/Shougo/deoplete.nvim.git ~/.vim/bundle/deoplete.nvim
echo ''

echo 'Installing apprentice theme'
mkdir ~/.vim/colors
wget https://github.com/romainl/Apprentice/raw/master/colors/apprentice.vim -O ~/.vim/colors/apprentice.vim
echo ''
