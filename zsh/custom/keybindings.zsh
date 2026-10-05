bindkey '^[[A' history-beginning-search-backward-end	# Up arrow
bindkey '^[[B' history-beginning-search-forward-end	# Down arrow

bindkey '^Z' fancy-ctrl-z
bindkey '^E' edit-command-line

bindkey -M menuselect '^[[A' up-line-or-history       # Up arrow
bindkey -M menuselect '^[[B' down-line-or-history     # Down arrow
bindkey -M menuselect '^[[C' forward-char             # Right arrow
bindkey -M menuselect '^[[D' backward-char            # Left arrow
bindkey -M menuselect '^[[Z' reverse-menu-complete    # Shift+Tab
