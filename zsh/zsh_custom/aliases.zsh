alias reload='source $HOME/.zshrc'
alias off='shutdown -h now'

# github copilot aliases
alias ghcs='gh copilot suggest'
alias ghce='gh copilot explain'

alias c='clear'

# eza / ls
alias ls='LS_COLORS= eza --git --color=always --group-directories-first --header --sort=name'
alias lt='ls --tree'

# nvim
alias n='nvim'
alias nf='nvim_fzf'
alias ng='nvim_grep'

alias f='fd_fzf'

# aliases for scripts that sync clipboard with iphone
alias icopy="get_clipboard.sh"
alias ipaste="put_clipboard.sh"

# directory aliases
alias cdf='cd_fzf'
alias dot='cd $DOTFILES_PATH'
alias cdl='cd_into_last_dir'

# git aliases
alias shlog='short_log_command_git'
