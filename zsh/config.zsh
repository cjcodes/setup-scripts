CWD=$HOME/.zsh.rc

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

source $CWD/omz.zsh
source $CWD/aliases.zsh
