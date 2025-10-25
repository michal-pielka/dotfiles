cd_fzf() {
	local dir
	dir=$(fd --type d . | fzf --no-preview)

	if [[ -n "$dir" ]]; then
		cd "$dir"
	fi
}

# Basically f='fd | fzf' with option to use flags like -e py, -t f etc.
fd_fzf() {
	fd "$@" | fzf
}

# nvim with fzf
nvim_fzf() {
	files=($(fd --type file "$@" | fzf --multi))

	if [ ${#files[@]} -gt 0 ]; then
		nvim "${files[@]}"
	fi
}

# nvim with ripgrep and fzf (live grep)
nvim_grep() {
	local file
	file=$(rg --line-number --no-heading --color=always "${1-}" | \
		fzf --ansi \
		--color "hl:-1:underline,hl+:-1:underline:reverse" \
		--delimiter ":" \
		--preview 'bat --style=full --color=always --highlight-line {2} {1}' | \
		awk -F: '{print $1}')

	if [[ -n "$file" ]]; then
		nvim "$file"
	fi
}

# Meant to be used with chpwd ZSH hook.
function cd_into_last_dir() {
	if [[ -f $XDG_RUNTIME_DIR/last_cd_dir_$USER ]]; then
		cd "$(cat $XDG_RUNTIME_DIR/last_cd_dir_$USER)"
	else
		echo "No last directory recorded."
	fi
}

short_log_command_git() {
	local n
	if [[ "$1" =~ ^[0-9]+$ ]]; then
		n=$1
		shift
	else
		n=10
	fi
	git --no-pager log --oneline -n "$n" "$@"
}

fzf_git_switch() {
	local branch
	branch=$(git branch --list --color | fzf --ansi --height=~40% | awk '{print $NF}')
	if [ -n "$branch" ]; then
		git switch "$branch"
	fi
}

open_file_in_zathura() {
	if [ "$#" -eq 0 ]; then
		return 1
	fi

	zathura $@ &>/dev/null &
	disown
}
