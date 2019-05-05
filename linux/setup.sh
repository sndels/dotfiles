#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo 'Add PPAs'
echo ''
sudo add-apt-repository ppa:neovim-ppa/stable
echo ''
sudo add-apt-repository ppa:jonathonf/i3
echo ''
echo ''

echo 'Get updates'
echo ''
sudo apt update
sudo apt dist-upgrade
echo ''
echo ''

echo 'Get basic utils'
echo ''
sudo apt install build-essential git cmake clang valgrind curl zsh htop python3-dev python3-pip
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo ''
echo ''

echo 'Get i3-gaps and friends'
echo ''
sudo apt install i3-gaps feh compton redshift
echo ''
echo ''

echo 'Get OpenGL and GLFW dependencies'
echo ' '
sudo apt install libgl1-mesa-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev
echo ''
echo ''

echo 'Get and set up neovim'
echo ''
sudo apt install neovim
sudo pip3 install pynvim
$DIR/../common/nvimsetup.sh

echo 'Get fonts'
echo ''
mkdir -p ~/.fonts/opentype
git clone --depth 1 --branch release https://github.com/adobe-fonts/source-code-pro.git ~/.fonts/opentype/scp
fc-cache -f -v
echo ''

echo 'Copy dotfiles and scripts'
echo ''
cp $DIR/.zshrc ~/.zshrc
mkdir -p ~/.i3
cp -r $DIR/.i3/. ~/.i3
mkdir -p ~/.config
cp -r $DIR/.config/. ~/.config
mkdir -p ~/bin
cp -r $DIR/bin/. ~/bin
cp -r $DIR/../common/. ~/
rm nvimsetup.sh
echo ''

if [ ! -f ~/.ssh/id_rsa ]
then
    echo 'Generate ssh key and setup agent'
    echo ''
    ssh-keygen -t rsa -b 4096 -C "santeri.salmijarvi@iki.fi"
    echo 'AddKeysToAgent yes' > ~/.ssh/config
    cat ~/.ssh/id_rsa.pub
    echo ''
    echo ''
fi

echo 'Get stuff from snap'
echo ''
sudo snap install chromium
sudo snap install code
sudo snap install --classic slack
sudo snap install spotify
sudo snap install telegram-desktop
echo ''
echo ''

echo 'Automagic setup done!'
echo 'Now'
echo '  put a cool image to ~/bg.png'
echo '  reboot to use i3'
echo '  get your'
echo '    NVIDIA driver blob? (dig a trench in case things break)'
echo '    Dropbox'
echo '    CUDA Toolkit?'
echo '    VulkanSDK?'
