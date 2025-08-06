# zsh-syntax-highlighting color variables
COLOR_GREEN="#AAED32"
COLOR_LILAC="#C8A2C8"
COLOR_ORANGE="#FFA500"

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
    # "#CF4500"
    # "#FF6500"
    # "#F08500"
    # "#E9BA00"
    # "#EAED32"
    # "#AAED32"
    # "#2AC3DE"  # blue0
    "#7DCFFF"  # cyan
    "#7AA2F7"  # blue2
    "#BB9AF7"  # purple
    # "#FF9E64"  # orange
    # "#9ECE6A"  # green

  )
  local output=""
  local color=""
  for (( i=0; i<${#text}; i++ )); do
    # Use modulus to loop through colors array without blank entries
    color=${colors[$((i + 1 % ${#colors[@]}))]}
    output+="%F{$color}${text:$i:1}"
  done
  echo -n "$output%f"  # Reset the formatting at the end
}

# Set the prompt with the desired colors and format
PROMPT="%F{red}%B[%b$(build_gradient) %F{#C8A2C8}%~%B%F{red}]%f%b$ "
