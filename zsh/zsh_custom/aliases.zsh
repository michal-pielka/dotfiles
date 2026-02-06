# System & Shell
alias reload='source $HOME/.zshrc'
alias off='shutdown -h now'
alias c='clear'

# Navigation
alias cdf='cd_fzf'
alias cdl='cd_into_last_dir'
alias rec='cd ~/videos/screen_recordings/'
alias dot='cd $DOTFILES_PATH'

# Global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g .......='../../../../../..'

alias -g C='| wl-copy'
alias -g G='| rg'
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sort'
alias -g U='| uniq'

# File System & Search
alias ls='LS_COLORS= eza --git --color=always --group-directories-first --header --sort=name'
alias l='ls -lah'
alias lt='ls --tree'
alias sl='ls'
alias f='fd_fzf'

# Editor
alias n='nvim'
alias nf='nvim_fzf'
alias ng='nvim_grep'

# Git
alias shlog='short_log_command_git'
alias gswf='fzf_git_switch'
alias ghf='github_search_repo_fzf'
alias ghcf='github_search_and_clone_repo_fzf'
alias glogi='git_log_interactive'

# Python
alias act='source .venv/bin/activate'
alias deact='deactivate'

# Apps & Utilities
alias zth=open_file_in_zathura
alias typstw=start_typst_preview
alias gcal='gcalcli'
alias wifi=wifi_fzf
alias teach=open_teacher_website_picker

# iPhone Clipboard Sync
alias icopy="get_clipboard.sh"
alias ipaste="put_clipboard.sh"

# Proxy
alias rmproxy="unset http_proxy && unset HTTP_PROXY && unset https_proxy && unset HTTPS_PROXY && unset all_proxy && unset ALL_PROXY"
alias mvd="mullvad"
