# Gruvbox colors
COLOR_GREEN="#b8bb26"
COLOR_LILAC="#d3869b"
COLOR_ORANGE="#fe8019"
COLOR_RED="#fb4934"
COLOR_YELLOW="#fabd2f"
COLOR_BLUE="#83a598"
COLOR_FG="#ebdbb2"
COLOR_BG="#282828"

# zsh-syntax-highlighting styles
ZSH_HIGHLIGHT_STYLES[command]="fg=${COLOR_GREEN}"
ZSH_HIGHLIGHT_STYLES[error]="fg=${COLOR_ORANGE}"
ZSH_HIGHLIGHT_STYLES[path]="fg=${COLOR_LILAC}"
ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=${COLOR_ORANGE}"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=${COLOR_GREEN}"
ZSH_HIGHLIGHT_STYLES[alias]="fg=${COLOR_GREEN}"
ZSH_HIGHLIGHT_STYLES[function]="fg=${COLOR_GREEN}"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=${COLOR_GREEN}"

# Terminal Prompt
build_gradient() {
  local text="plk"
  local colors=(
    "$COLOR_YELLOW"
    "$COLOR_ORANGE"
    "$COLOR_RED"
  )
  local output=""
  local color=""
  local idx=0
  for (( i=0; i<${#text}; i++ )); do
    idx=$(( (i % ${#colors[@]}) + 1 ))   # fix index: zsh arrays are 1-based
    color=${colors[$idx]}
    output+="%F{$color}${text:$i:1}"
  done
  echo -n "$output%f"
}

PROMPT="%F{$COLOR_FG}%B[%b%F %F{$COLOR_RED)}%~ %B%F{$COLOR_FG}]%f$%b "
