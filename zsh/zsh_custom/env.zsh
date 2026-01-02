# Paths and environment variables
export ZSH="$HOME/.oh-my-zsh"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$DOTFILES_PATH/scripts:$PATH"

# nvim colors
export TERM=xterm-256color

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_R_OPTS="--no-preview"

# --bind="tab:toggle-preview-full" only works using my fzf fork
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
  --prompt=" "
  --gutter=" "
  --separator=""
  --scrollbar=""
  --layout="reverse"
  --bind="tab:toggle-preview-full,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
  --height=~65%
  --pointer="■"
  --preview "bat --style=numbers --color=always --line-range :500 {} 2>/dev/null"'

# bat
export BAT_THEME="gruvbox-dark"

# general
export EDITOR=nvim
export MANPAGER='nvim +Man!'

# zsh history
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=10000

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
