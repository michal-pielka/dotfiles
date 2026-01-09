# Zcomet init
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# Loading/installing plugins
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load ohmyzsh plugins/git
zcomet load softmoth/zsh-vim-mode

zcomet compinit
