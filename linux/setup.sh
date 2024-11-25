#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p ~/tmp
cd ~/tmp

echo '======================= Setup package repositories ======================='
echo ''
wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.6_all.deb
sudo dpkg -i protonvpn-stable-release_1.0.6_all.deb
echo ''
echo ''

echo '============================== Get updates ==============================='
echo ''
sudo apt update
sudo apt dist-upgrade -y
echo ''
echo ''

echo '=========== Install AMD proprietary vulkan driver (RT support) ==========='
echo ''
wget http://repo.radeon.com/amdgpu-install/6.2.4/ubuntu/noble/amdgpu-install_6.2.60204-1_all.deb
sudo apt update
sudo amdgpu-install -y --usecase=graphics --vulkan=pro --accept-eula
echo ''
echo ''

echo '============================= Get basic utils ============================'
echo ''
sudo apt install -y build-essential git cmake clang-18 clangd-18 clang-tidy-18 clang-format-18 valgrind curl zsh htop python3-pip python3-venv black ninja-build ripgrep mold pulseaudio
echo ''
#echo 'Install libstdc++-12-dev as a workaround for broken clang'
# Seems like some 22.04 update and/or installing gcc-12 through some package dependency breaks things
# sudo apt install -y libstdc++-12-dev
#echo ''
#echo ''

echo '====================== Get kitty and setup terminal ======================'
echo ''
sudo apt install -y kitty
RUNZSH=no sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
echo ''
echo 'Running default terminal selection, pick kitty'
sudo update-alternatives --config x-terminal-emulator
echo ''
echo ''

echo '================================ Get Rust ================================'
echo ''
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo ''
echo ''

echo '========================== Get sway and friends =========================='
echo ''
sudo apt install -y sway dmenu brightnessctl swaylock grimshot

echo '=============== Add user to video-group for brightnessctl ================'
sudo gpasswd -a $USER video

echo '==================== Install i3status-rs from source ====================='
echo ''
git clone https://github.com/greshake/i3status-rust.git
cd i3status-rust
git checkout v0.30.4
sudo apt install -y libssl-dev libsensors-dev libpulse-dev pandoc
cargo install --path . --locked
./install.sh
cd ~/tmp
echo ''
echo ''

echo '==================== Get OpenGL and GLFW dependencies ===================='
echo ' '
sudo apt install -y libgl1-mesa-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev libwayland-dev libxkbcommon-dev
echo ''
echo ''

echo '===================== Get Rust windowing dependencies ===================='
echo ' '
sudo apt install -y librust-atk-dev libgtk-3-dev
echo ''
echo ''

echo '=============================== VulkanSDK ================================'
echo ''
# Copied for the specific version from https://vulkan.lunarg.com/sdk/home#linux
wget -qO - https://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo apt-key add -
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-1.3.296-noble.list https://packages.lunarg.com/vulkan/1.3.296/lunarg-vulkan-1.3.296-noble.list
sudo apt update
sudo apt install -y vulkan-sdk
echo ''
echo ''

echo '========================== Get and set up neovim ========================='
echo ''
sudo snap install nvim --classic
$DIR/../common/nvimsetup.sh
echo ''
echo ''

echo '=============================== Get fonts ================================'
echo ''
sudo apt install -y fonts-firacode fonts-font-awesome
wget https://github.com/intel/intel-one-mono/releases/download/V1.3.0/ttf.zip
unzip ttf.zip
sudo mv ttf /usr/share/fonts/truetype/IntelOneMono
sudo fc-cache -f
rm ttf.zip
echo ''
echo ''

echo '======================== Copy dotfiles and scripts ======================='
echo ''
cp $DIR/.zshrc ~/.zshrc
mkdir -p ~/.config
cp -r $DIR/.config/. ~/.config
mkdir -p ~/bin
cp -r $DIR/bin/. ~/bin
cp -r $DIR/../common/. ~/
rm nvimsetup.sh
wget https://github.com/Wilfred/difftastic/releases/download/0.58.0/difft-x86_64-unknown-linux-gnu.tar.gz
tar xf difft-x86_64-unknown-linux-gnu.tar.gz
mv difft ~/bin

echo '=========================== Get stuff from snap =========================='
echo ''
sudo snap install --classic code
sudo snap install slack
sudo snap install spotify
sudo snap install telegram-desktop
echo ''
echo ''

echo '=========================== Get zed =========================='
echo ''
curl -f https://zed.dev/install.sh | sh
echo ''
echo ''

echo '============================== Setup vscode =============================='
echo ''
mkdir -p ~/.config/Code/User
cp $DIR/vscode.json ~/.config/Code/User/settings.json
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

echo '============================== Get ProtonVPN ============================='
echo ''
sudo apt install -y protonvpn
echo ''
echo ''


if [ ! -f ~/.ssh/id_ed25519 ]
then
    echo '==================== Generate ssh key and setup agent ===================='
    echo ''
    ssh-keygen -t ed25519 -C "santeri.salmijarvi@iki.fi"
    echo 'AddKeysToAgent yes' > ~/.ssh/config
    cat ~/.ssh/id_ed25519.pub
    echo ''
    echo ''
fi

echo 'Automagic setup done!'
echo 'Now'
echo '  Connect proton and verify the VPN setup'
echo '    https://www.dnsleaktest.com/'
echo '  Add the Finnish keyboard layout'
echo '  put a cool image to ~/.config/sway/bg.png'
echo '  set up the BT headset'
echo "    pair once through gnome's BT ui"
echo '    put the id into ~/.config/fiio_id'
echo '  reboot to use sway'
