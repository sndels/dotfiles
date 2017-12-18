# Path to your oh-my-zsh installation.
  export ZSH=/home/sndels/.oh-my-zsh

ZSH_THEME="agnoster"

plugins=(git)

# User configuration

# Set paths
export PATH=$PATH:/usr/include/eigen3/
export LD_LIBRARY_PATH=/usr/local/lib
export CMAKE_PREFIX_PATH=/usr/local/lib/cmake
export CMAKE_MODULE_PATH=/usr/share/SFML/cmake/Modules

# Bind capslock to esc
/usr/bin/setxkbmap -option "caps:swapescape"

# Set layout toggle
/usr/bin/setxkbmap -layout us,fi
/usr/bin/setxkbmap -option "grp:alt_shift_toggle"

# Clang as default compiler
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

source $ZSH/oh-my-zsh.sh
