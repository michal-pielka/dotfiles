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
    "#ebdbb2"
    "#ebdbb2"
    "#ebdbb2"

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
PROMPT="%F{red}%B[%b$(build_gradient) %F{magenta}%~%B%F{red}]%f%b$ "
