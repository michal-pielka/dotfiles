if [ ! -d ".git" ]; then
    echo "Please run this script from the root directory of the dotfiles repository."
    exit 1
fi

DEFAULT_THEME="gruvbox"
CWD=$(pwd)
CURRENT_LINK="$CWD/themes/current"

# Ensure themes/current exists; default to "gruvbox"
if [ ! -e "$CURRENT_LINK" ]; then
    if [ -d "$CWD/themes/$DEFAULT_THEME" ]; then
        ln -sfn "$CWD/themes/$DEFAULT_THEME" "$CURRENT_LINK"
        echo "Created theme symlink: current -> $DEFAULT_THEME"
    else
        echo "Default theme not found: $CWD/themes/$DEFAULT_THEME"
        exit 1
    fi
fi

pairs=(
  "zsh.zsh $CWD/zsh/zsh_custom/theme.zsh"
  "eza.yml $CWD/eza/theme.yml"
  "foot.ini $CWD/foot/theme.ini"
  "fuzzel.ini $CWD/fuzzel/theme.ini"
  "hyprland.conf $CWD/hypr/modules/theme.conf"
  "mako.conf $CWD/mako/theme.conf"
  "nvim.lua $CWD/nvim/lua/plugins/colorscheme.lua"
  "waybar.css $CWD/waybar/theme.css"
)

for pair in "${pairs[@]}"; do
  src_file="${pair%% *}"
  dest_path="${pair#* }"
  src_full="$CURRENT_LINK/$src_file"
  dest_dir=$(dirname "$dest_path")

  if [ ! -e "$src_full" ]; then
      echo "  Warning: Source file not found: $src_full"
      continue
  fi

  if [ ! -d "$dest_dir" ]; then
      mkdir -p "$dest_dir"
      echo "  Created directory: $dest_dir"
  fi

  if [ -L "$dest_path" ] && [ "$(readlink -f "$dest_path")" = "$(readlink -f "$src_full")" ]; then
      echo "  $(basename "$dest_path") already linked correctly"
      continue
  fi

  ln -sfn "$src_full" "$dest_path"
  echo "  Created symlink: $dest_path -> $src_full"
done

echo ""
echo "Theme symlink setup complete!"
