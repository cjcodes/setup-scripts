export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""
autoload -U promptinit; promptinit
prompt pure

zstyle ':omz:update' mode auto
zstyle ':omz:update' verbose silent
zstyle ':omz:update' frequency 13

# plugins=(asdf)
plugins=()

source $ZSH/oh-my-zsh.sh
