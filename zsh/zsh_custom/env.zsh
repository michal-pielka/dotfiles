# Path
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$DOTFILES_PATH/scripts:$PATH"

# Editor
export EDITOR=nvim
export MANPAGER='nvim +Man!'

# Terminal
export TERM=xterm-256color

# ZSH History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=10000

# Bat
export BAT_THEME="gruvbox-dark"

# Fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_R_OPTS="--no-preview"

# Note: tab:toggle-preview-full requires my fzf fork
export FZF_DEFAULT_OPTS='
  --color=fg:-1,fg+:-1
  --color=bg:-1,bg+:-1
  --color=hl:-1,hl+:#fb4a34
  --color=info:#458588
  --color=marker:#fb4a34
  --color=prompt:#fb4a34
  --color=spinner:#d79921
  --color=pointer:#d79921
  --color=header:#87afaf
  --color=gutter:-1
  --color=border:#ebdbb2
  --color=label:#aeaeae
  --color=query:#f9f5d7
  --border="sharp"
  --border-label=""
  --preview-window="hidden,sharp"
  --prompt=" "
  --gutter=" "
  --separator=""
  --scrollbar=""
  --layout="reverse"
  --bind="tab:toggle-preview-full,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
  --height=~65%
  --pointer="■"
  --preview "bat --style=numbers --color=always --line-range :500 {} 2>/dev/null"'
