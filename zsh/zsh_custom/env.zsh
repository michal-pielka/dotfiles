# Paths and environment variables
export ZSH="$HOME/.oh-my-zsh"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
export PATH="/opt/gcc-13.1.0/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# nvim colors
export TERM=xterm-256color

# fzf 
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='
  --color=fg:-1,fg+:#f9f5d7,bg:-1,bg+:#262626
  --color=hl:#ebdbb2,hl+:#f9f5d7,info:#458588,marker:#FB4A34
  --color=prompt:#fb4a34,spinner:#d79921,pointer:#d79921,header:#87afaf
  --color=gutter:-1,border:#ebdbb2,label:#aeaeae,query:#f9f5d7
  --border="sharp" --border-label="" --preview-window="sharp" --margin="5%"
  --prompt=" " --separator=""
  --scrollbar="" --layout="reverse"
  --preview "bat --style=numbers --color=always --line-range :500 {} 2>/dev/null"'
export FZF_CTRL_R_OPTS="--no-preview"

# bat
export BAT_THEME="gruvbox-dark"
