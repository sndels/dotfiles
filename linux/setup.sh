#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p ~/tmp
cd ~/tmp

echo 'Get updates'
echo ''
sudo apt update
sudo apt dist-upgrade
echo ''
echo ''

echo 'Get basic utils'
echo ''
sudo apt install build-essential git cmake clang valgrind curl zsh htop python3-pip
echo ''
echo ''

echo 'Get kitty and setup terminal'
echo ''
sudo apt install kitty
RUNZSH=no sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
echo ''
echo 'Running default terminal selection, pick kitty'
sudo update-alternatives --config x-terminal-emulator
echo ''
echo ''

echo 'Get Rust'
echo ''
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo ''
echo ''

echo 'Get i3 and friends'
echo ''
echo "i3 4.22 (with gaps merge) wasn't out when making this script."
echo 'Check if it is now released and available as a package,'
echo 'or press any key to continue and install from source'
read -n 1
# TODO: Just grab i3 from apt once 4.22 is available instead of this mess
git clone https://github.com/i3/i3.git
cd i3
git checkout ab6f1fd1601e58c2f5db113f6566cdf8e015c119
sudo apt install meson ninja-build debhelper libx11-dev libxcb-util0-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-cursor-dev libxcb-xrm-dev libxcb-xkb-dev libxcb-shape0-dev libxkbcommon-dev libxkbcommon-x11-dev asciidoc xmlto docbook-xml pkg-config libev-dev libyajl-dev libpcre2-dev libstartup-notification0-dev libcairo2-dev libpango1.0-dev libpod-simple-perl
mkdir -p build
cd build
meson ..
ninja install
cd ~/tmp

sudo apt install i3status feh
echo ''
echo ''

echo 'Get OpenGL and GLFW dependencies'
echo ' '
sudo apt install libgl1-mesa-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev
echo ''
echo ''

echo 'VulkanSDK'
echo ''
# Copied for the specific version from https://vulkan.lunarg.com/sdk/home#linux
wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo tee /etc/apt/trusted.gpg.d/lunarg.asc
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-1.3.236-jammy.list https://packages.lunarg.com/vulkan/1.3.236/lunarg-vulkan-1.3.236-jammy.list
sudo apt update
sudo apt install vulkan-sdk
echo ''
echo ''

echo 'Get and set up neovim'
echo ''
sudo apt install neovim
$DIR/../common/nvimsetup.sh
echo ''
echo ''

echo 'Get fonts'
echo ''
sudo apt install fonts-firacode
echo ''
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
sudo snap install --classic code
sudo snap install slack
sudo snap install spotify
sudo snap install telegram-desktop
echo ''
echo ''

echo 'Setup vscode'
echo ''
mkdir -p ~/.config/Code/User
cp $DIR/linux/vscode.json ~/.config/Code/User/settings.json
code --install-extension joshneta.65816-assembly
code --install-extension bungcip.better-toml
code --install-extension ms-vscode.cpptools
code --install-extension xaver.clang-format
code --install-extension josetr.cmake-language-support-vscode
code --install-extension vadimcn.vscode-lldb
code --install-extension usernamehw.errorlens
code --install-extension eamodio.gitlens
code --install-extension ms-vscode.hexeditor
code --install-extension ms-python.isort
code --install-extension ms-python.python
code --install-extension rust-lang.rust-analyzer
code --install-extension slevesque.shader
code --install-extension vscodevim.vim
code --install-extension sndels.vulkan-api-docs
echo ''
echo ''


echo 'Automagic setup done!'
echo 'Now'
echo '  put a cool image to ~/bg.png'
echo '  reboot to use i3'
echo '  get your'
echo '    graphics driver? TODO: wget amd and install blob in the script'
