# Function to change into a subdirectory selected with FZF.
# Implements the logic: cd $(fd --type d . | fzf)
cd_fzf() {
  local dir
  dir=$(fd --type d . | fzf)

  # Only change directory if a selection was made
  if [[ -n "$dir" ]]; then
    cd "$dir"
  fi
}

# fd, fzf aliases
# Basically f='fd | fzf' with option to use flags like -e py, -t f etc.
fd_fzf() {
  fd "$@" | fzf
}

# nvim with fzf
# The following is basically: nf='nvim $(fd | fzf --multi' with the option to abort and add flags like -e py, -t f etc.
# Default behavior is to only search for files (-t f).
nvim_fzf() {
  # Run fd with a default type of 'file', but allow user to add/override with their own flags ("$@").
  # For example, `nf -t d` will work because the user's -t d flag overrides the default -t f.
  files=($(fd --type file "$@" | fzf --multi))

  # If we got at least one selection, open with nvim.
  if [ ${#files[@]} -gt 0 ]; then
    nvim "${files[@]}"
  fi
}

# nvim with ripgrep and fzf (live grep)
# The idea is to use fzf to select a file from the output of ripgrep,
# and then open it in nvim.
nvim_grep() {
  # Use ripgrep to search for a pattern in all files.
  # The output is piped to fzf for interactive selection.
  # We use --preview with bat to show the file content with syntax highlighting.
  # The selected line format is "file:line_number:...", so we use awk to extract the file path.
  local file
  file=$(rg --line-number --no-heading --color=always "${1-}" | \
    fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter ":" \
        --preview 'bat --style=full --color=always --highlight-line {2} {1}' | \
    awk -F: '{print $1}')

  # If a file was selected, open it in nvim.
  if [[ -n "$file" ]]; then
    nvim "$file"
  fi
}
