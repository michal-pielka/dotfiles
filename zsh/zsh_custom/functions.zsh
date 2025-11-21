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

# git functions
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

github_search_repo_fzf() {
  if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <repo-name>"
    return 1
  fi

  gh search repos --json fullName,stargazersCount,description "$@" \
    | jq -r '(map(.stargazersCount) | max | tostring | length) as $maxlen
      | .[]
      | "\u001b[33m\(.stargazersCount | tostring | length as $len
         | if $len < $maxlen then ($maxlen - $len | " " * .) + "\(.)" else "\(.)" end)\u001b[0m - \(.fullName) - \(.description)"' \
      | fzf --height=~100% --preview-window="hidden,sharp,80%" --ansi --prompt='Select repository: ' \
          --preview 'bash -c '"'"'
            repo=$(awk -F " - " "{print \$2}" <<< "$1")
            [ -z "$repo" ] && { echo "No repo parsed"; exit 0; }

			readme=$(gh api -H "Accept: application/vnd.github.v3.raw" "repos/$repo/readme" 2>/dev/null)
			if [ -z "$readme" ]; then
				echo "No README found or failed to fetch."
				exit 0
			fi

			# Print the README content via glow
			echo "$readme" | env -u NO_COLOR CLICOLOR_FORCE=1 glow --style=dark -
          '"'"' -- {}' \
    | awk -F ' - ' '{print $2}'
}

github_search_and_clone_repo_fzf() {
    if [ $# -lt 1 ]; then
        github_search_repo_fzf # Let it handle showing the usage and error
        return 1
    fi

    local repo
    repo=$(github_search_repo_fzf "$@") || return 1

    if [ -z "$repo" ]; then
        echo "No repository selectedk." >&2
        return 1
    fi

    gh repo clone "$repo"
}

fzf_git_switch() {
	local branch
	branch=$({
			git branch --color | grep '^\*';   # current branch
			git branch --color | grep -v '^\*' # all others
		} | fzf --ansi --height=~40% | awk '{print $NF}'
	)

	[ -n "$branch" ] && git switch "$branch"
}

open_file_in_zathura() {
	if [ "$#" -eq 0 ]; then
		return 1
	fi

	zathura $@ &>/dev/null &
	disown
}

open_teacher_website_picker() {
	selected=$(cat "$HOME/.scriptfiles/prowadzacy.txt" | fzf --delimiter ";" --with-nth=2.. --accept-nth 1)
	if [ -n "$selected" ]; then
		xdg-open "$selected" > /dev/null 2>&1 & disown
	fi
}

start_typst_preview() {
  typst watch $@ &>/dev/null &
  disown
}
