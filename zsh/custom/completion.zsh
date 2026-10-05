# Load complist module for menu selection
zmodload -i zsh/complist

# Combined matcher-list: case-insensitive + partial matching
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# Enable visual menu selection
zstyle ':completion:*' menu select

# Prioritize local directories for cd
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Enable caching for faster completions
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# Navigate completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
