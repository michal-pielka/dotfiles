# Paths and environment variables
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
export PATH="/opt/gcc-13.1.0/bin:$PATH"

# Neovim colors
export TERM=xterm-256color

# FZF 
export FZF_DEFAULT_OPTS="
  --height=80%
  --layout=reverse
  --border
  --preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null'
  --color=bg+:#23272e,bg:#181c22,spinner:#FB4A34,hl:#b8bb26
  --color=fg:#a89984,header:#83a598,info:#458588,pointer:#FB4A34
  --color=marker:#b8bb26,fg+:#ebdbb2,prompt:#FB4A34,hl+:#fabd2f
  --prompt=' '
  --border
  --margin=8%,7%
"

export FZF_DEFAULT_COMMAND='fd --type f'
export BAT_THEME="gruvbox-dark"
export EZA_CONFIG_DIR="/Users/michalpielka/.config/eza"
