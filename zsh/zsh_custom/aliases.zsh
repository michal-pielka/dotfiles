alias reload='source $HOME/.zshrc'
alias off='shutdown -h now'

# github copilot aliases
alias ghcs='gh copilot suggest'
alias ghce='gh copilot explain'

alias c='clear'

# eza / ls
alias ls='LS_COLORS= eza --git --color=always --group-directories-first --header --sort=name'
alias lt='ls --tree'
alias sl='ls'

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
alias cdl='cd_into_last_dir'
alias rec='cd ~/videos/screen_recordings/'
alias dot='cd $DOTFILES_PATH'

# git aliases
alias shlog='short_log_command_git'
alias gswf='fzf_git_switch'
alias ghf='github_search_repo_fzf'
alias ghcf='github_search_and_clone_repo_fzf'

alias zth=open_file_in_zathura

alias teach=open_teacher_website_picker

alias gcal='gcalcli'

# pyenv
alias act='source .venv/bin/activate'
alias deact='deactivate'

alias typstw=start_typst_preview

alias wifi=wifi_fzf

alias cat='bat --pager never'
