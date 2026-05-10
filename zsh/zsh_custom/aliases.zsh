# System & Shell
alias reload='source $HOME/.zshrc'
alias off='shutdown -h now'
alias c='clear'

# Navigation
alias cdf='cd_fzf'
alias cdl='cd_into_last_dir'
alias rec='cd ~/videos/screen_recordings/'
alias dot='cd $DOTFILES_PATH'

# Path
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g .......='../../../../../..'
alias cppwd="pwd | wl-copy"

# Pipe aliases
alias -g C='| wl-copy'
alias -g G='| rg'
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sort'
alias -g U='| uniq'
alias -g W='| wc'
alias -g F='| fzf'

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
alias opgurl='open_git_url'
alias shipbranch='gh_pr_create_and_auto_merge'

# Python
alias py='python3'
alias act='source .venv/bin/activate'
alias deact='deactivate'
alias rmpyc='fd -t d -g "__pycache__" -I -x rm -r'

# Rust/Cargo
alias cr='cargo run --release'
alias cb='cargo build --release'
alias ca='cargo add'
alias ct='cargo test'

# Apps & Utilities
alias zth='open_file_in_zathura'
alias typstw='start_typst_preview'
alias gcal='gcalcli'
alias wifi='wifi_fzf'
alias teach='open_teacher_website_picker'
alias shai='claude-shell-helper'
alias im='open_file_in_imv'
alias imf='open_file_in_imv_floating'
alias spotify='spotify_player'

# iPhone Clipboard Sync
alias icopy="get_clipboard.sh"
alias ipaste="put_clipboard.sh"

# Network
alias rmproxy="unset http_proxy && unset HTTP_PROXY && unset https_proxy && unset HTTPS_PROXY && unset all_proxy && unset ALL_PROXY"
alias mvd="mullvad"
alias mvdc="mullvad connect"
alias mvdd="mullvad disconnect"
alias mvds="mullvad status"
