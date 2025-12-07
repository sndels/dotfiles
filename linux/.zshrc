# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="agnoster"

# Hide username@hostname
export DEFAULT_USER=$USER

plugins=(git)

alias vim=nvim

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

source $HOME/vulkan/1.4.328.1/setup-env.sh
source $ZSH/oh-my-zsh.sh
