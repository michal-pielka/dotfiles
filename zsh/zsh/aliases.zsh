alias reload='source ~/.zshrc'
alias off='shutdown -h now'

# gitHub copilot aliases
alias ghcs='gh copilot suggest'
alias ghce='gh copilot explain'

# Common shortcuts
alias c='clear'
alias n='nvim'

alias ff='fastfetch'

# fd, fzf aliases
# Basically f='fd | fzf' with option to use flags like -e py, -t f etc.
f() {
  fd "$@" | fzf
}

# nvim with fzf
# The following is basically: nf='nvim $(fd | fzf --multi' with the option to abort and add flags like -e py, -t f etc.
# Default behavior is to only search for files (-t f).
nf() {
  # Run fd with a default type of 'file', but allow user to add/override with their own flags ("$@").
  # For example, `nf -t d` will work because the user's -t d flag overrides the default -t f.
  files=($(fd --type file "$@" | fzf --multi))

  # If we got at least one selection, open with nvim.
  if [ ${#files[@]} -gt 0 ]; then
    nvim "${files[@]}"
  fi
}

# eza / ls
alias ls='LS_COLORS= eza --git --color=always --group-directories-first --header --sort=name'
alias lt='ls --tree'

# alias for old nvim config
 alias nvim-old='NVIM_APPNAME="nvim-old" nvim'
