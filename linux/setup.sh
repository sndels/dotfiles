#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p ~/tmp

echo '============================== Get updates ==============================='
echo ''
sudo apt update
sudo apt dist-upgrade -y
echo ''
echo ''

echo '============================= Get basic utils ============================'
echo ''
sudo apt install -y build-essential git cmake clang-19 clangd-19 clang-tidy-19 clang-format-19 valgrind curl zsh htop python3-pip python3-venv black ninja-build mold pulseaudio || exit 1
echo ''

echo '============================= Get librewolf ============================'
echo ''
sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update && sudo apt install librewolf -y
echo ''

echo '====================== Get ghostty and setup terminal ======================'
echo ''
cd ~/tmp
wget https://ziglang.org/download/0.14.1/zig-x86_64-linux-0.14.1.tar.xz
tar xf zig-x86_64-linux-0.14.1.tar.xz
wget https://release.files.ghostty.org/1.2.3/ghostty-1.2.3.tar.gz
tar xf ghostty-1.2.3.tar.gz
sudo apt install libgtk-4-dev libadwaita-1-dev gettext libxml2-utils
cd ghostty-1.2.3
../zig-x86_64-linux-0.14.1/zig build -p $HOME/.local -Doptimize=ReleaseFast -fno-sys=gtk4-layer-shell
cd ~/tmp
RUNZSH=no sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
echo ''
echo 'Running default terminal selection, pick ghostty'
sudo update-alternatives --config x-terminal-emulator
echo ''
echo ''

echo '================================ Get Rust ================================'
echo ''
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo ''
echo ''

echo '================================ Get sourcegit ================================'
echo ''
cd ~/tmp
wget https://github.com/sourcegit-scm/sourcegit/releases/download/v2025.39/sourcegit_2025.39-1_amd64.deb
sudo apt install ./sourcegit_2025.39-1_amd64.deb
echo ''
echo ''


echo '========================== Get sway and friends =========================='
echo ''
sudo apt install -y sway dmenu brightnessctl swaylock grimshot

echo '=============== Add user to video-group for brightnessctl ================'
sudo gpasswd -a $USER video

echo '==================== Install i3status-rs from source ====================='
echo ''
cd ~/tmp
git clone https://github.com/greshake/i3status-rust.git
cd i3status-rust
git checkout v0.33.2
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
sudo apt install -y libgtk-3-dev
echo ''
echo ''

echo '=============================== VulkanSDK ================================'
echo ''
# Copied for the specific version from https://vulkan.lunarg.com/sdk/home#linux
cd ~/tmp
wget https://sdk.lunarg.com/sdk/download/1.4.335.0/linux/vulkansdk-linux-x86_64-1.4.335.0.tar.xz
tar xvf vulkansdk-linux-x86_64-1.4.335.0.tar.xz
mkdir ~/vulkan
cp -r 1.4.335.0 ~/vulkan/
sudo apt install libxcb-xinput0 libxcb-xinerama0 libxcb-cursor-dev
# vulkan setup-env.sh is sourced in .zshrc
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
cd ~/tmp
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
echo ''
echo ''

echo '======================== Get difftastic ======================='
echo ''
cd ~/tmp
wget https://github.com/Wilfred/difftastic/releases/download/0.67.0/difft-x86_64-unknown-linux-gnu.tar.gz
tar xf difft-x86_64-unknown-linux-gnu.tar.gz
mv difft ~/bin
echo ''
echo ''

echo '=========================== Get more stuff from snap =========================='
echo ''
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

echo '============================== Get ProtonVPN ============================='
echo ''
cd ~/tmp
wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.8_all.deb
sudo dpkg -i protonvpn-stable-release_1.0.8_all.deb
sudo apt install -y protonvpn
sudo apt install -y proton-vpn-cli
echo ''
echo ''

echo '============================== Get Steam ============================='
echo ''
cd ~/tmp
wget https://cdn.fastly.steamstatic.com/client/installer/steam.deb
sudo apt install ./steam.deb
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
