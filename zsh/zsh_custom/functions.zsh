# Navigation
cd_fzf() {
	local dir
	dir=$(fd --type d . | fzf --no-preview)

	if [[ -n "$dir" ]]; then
		cd "$dir"
	fi
}

cd_into_last_dir() {
	if [[ -f $XDG_RUNTIME_DIR/last_cd_dir_$USER ]]; then
		cd "$(cat $XDG_RUNTIME_DIR/last_cd_dir_$USER)"
	else
		echo "No last directory recorded."
	fi
}

# File System
fd_fzf() {
	fd "$@" | fzf
}

# Editor
nvim_fzf() {
	files=($(fd --type file "$@" | fzf --multi))

	if [ ${#files[@]} -gt 0 ]; then
		nvim "${files[@]}"
	fi
}

nvim_grep() {
    local RELOAD='reload:rg --column --color=always --smart-case {q} || :'
    local OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
                    "$EDITOR" {1} +{2}
                  elif [[ $EDITOR == vim ]] || [[ $EDITOR == nvim ]]; then
                    "$EDITOR" +cw -q {+f}
                  else
                    "$EDITOR" {+1}
                  fi'

    fzf --disabled --ansi --multi --query "${*:-}" \
        --bind "start,change:$RELOAD" \
        --bind "enter:become:$OPENER" \
        --delimiter : \
        --preview 'bat --color=always --highlight-line {2} {1}' \
}

# Git
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
	branch=$({
			git branch --color | rg '^\*';
			git branch --color | rg -v '^\*'
		} | fzf --ansi --height=~40% | awk '{print $NF}'
	)

	[ -n "$branch" ] && git switch "$branch"
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

			echo "$readme" | env -u NO_COLOR CLICOLOR_FORCE=1 glow --style=dark -
          '"'"' -- {}' \
    | awk -F ' - ' '{print $2}'
}

github_search_and_clone_repo_fzf() {
    if [ $# -lt 1 ]; then
        github_search_repo_fzf
        return 1
    fi

    local repo
    repo=$(github_search_repo_fzf "$@") || return 1

    if [ -z "$repo" ]; then
        echo "No repository selected." >&2
        return 1
    fi

    gh repo clone "$repo"
}

# Apps & Utilities
open_file_in_zathura() {
	if [ "$#" -eq 0 ]; then
		return 1
	fi

	zathura $@ &>/dev/null &
	disown
}

start_typst_preview() {
  typst watch $@ &>/dev/null &
  disown
}

open_teacher_website_picker() {
	selected=$(cat "$HOME/.scriptfiles/prowadzacy.txt" | fzf --delimiter ";" --with-nth=2.. --accept-nth 1)
	if [ -n "$selected" ]; then
		xdg-open "$selected" > /dev/null 2>&1 & disown
	fi
}

wifi_fzf() {
	nmcli -f 'bssid,signal,bars,freq,ssid' --color yes device wifi |
		fzf \
		--with-nth=2.. \
		--ansi \
		--height=~50% \
		--reverse \
		--cycle \
		--no-info \
		--header-lines=1 \
		--bind="enter:execute:nmcli -a device wifi connect {1}"
}

git_log_interactive() {
  local selected=$(git log -n 100 --pretty=format:'%h %s' "$@" | \
    fzf --ansi \
        --preview 'git show {1} --pretty=format: | delta --paging=never' \
        --preview-window=right:60% \
        --delimiter=' ' \
        --with-nth=1,2.. \
        --layout=reverse \
        --header-label ' commit ' \
        --bind 'focus:+bg-transform-header:if [[ -n {} ]]; then
                  git show {1} -q | head -n5 | delta --paging=never
                fi' \
        --bind "ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up")

  if [[ -z $selected ]]; then
    return 1
  fi

  local short_hash="${selected%% *}"
  local full_hash=$(git rev-parse "$short_hash")

  echo "$full_hash"
}
