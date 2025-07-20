# Function to change into a subdirectory selected with FZF.
# Implements the logic: cd $(fd --type d . | fzf)
cdf() {
  local dir
  dir=$(fd --type d . | fzf)

  # Only change directory if a selection was made
  if [[ -n "$dir" ]]; then
    cd "$dir"
  fi
}

