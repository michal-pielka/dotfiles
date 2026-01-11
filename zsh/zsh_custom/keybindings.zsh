# History search with prefix matching
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end 	# Up arrow
bindkey '^[[B' history-beginning-search-forward-end		# Down arrow

# Ctrl + Z will fg the job that's in the background.
fancy-ctrl-z () {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER="fg"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

bindkey -M menuselect '^[[A' up-line-or-history       # Up arrow
bindkey -M menuselect '^[[B' down-line-or-history     # Down arrow
bindkey -M menuselect '^[[C' forward-char             # Right arrow
bindkey -M menuselect '^[[D' backward-char            # Left arrow
bindkey -M menuselect '^[[Z' reverse-menu-complete    # Shift+Tab
