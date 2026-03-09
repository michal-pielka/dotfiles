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

# Edit current command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line

# History search with prefix matching
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
