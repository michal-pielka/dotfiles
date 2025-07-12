# Source ~/.zshrc
alias reload='source ~/.zshrc'

# GitHub Copilot aliases
alias ghcs='gh copilot suggest'
alias ghce='gh copilot explain'

# Hide/unhide Desktop files
alias hide='chflags hidden ~/Desktop/*'
alias unhide='chflags nohidden ~/Desktop/*'

# Common shortcuts
alias c='clear'
alias n='nvim'
alias copy='pbcopy'

# Display images in kitty terminal
alias kimg='kitty +kitten icat'

# fd, fzf aliases
# Basically f='fd | fzf' with option to use flags like -e py, -t f etc.
f() {
  fd "$@" | fzf
}

# nvim with fzf
# The following is basically: nf='nvim $(fd | fzf --multi' with the option to abort and add flags like -e py, -t f etc.
nf() {
  # Run fd with all the args, pipe into fzf (multi‑select)
  files=($(fd "$@" | fzf --multi))

  # If we got at least one selection, open with nvim
  if [ ${#files[@]} -gt 0 ]; then
    nvim "${files[@]}"
  fi
}

# eza / ls
alias ls='eza --git --color=always --group-directories-first --header --sort=name'
alias lt='ls --tree'
