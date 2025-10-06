pairs=(
  "zsh.zsh $DOTFILES_PATH/zsh/zsh_custom/theme.zsh"
  "eza.yml $DOTFILES_PATH/eza/theme.yml"
  "foot.ini $DOTFILES_PATH/foot/theme.ini"
  "fuzzel.ini $DOTFILES_PATH/fuzzel/theme.ini"
  "hyprland.conf $DOTFILES_PATH/hypr/modules/theme.conf"
  "mako.conf $DOTFILES_PATH/mako/theme.conf"
  "nvim.lua $DOTFILES_PATH/nvim/lua/plugins/colorscheme.lua"
  "waybar.css $DOTFILES_PATH/waybar/theme.css"
)

for pair in "${pairs[@]}"; do
  src_file="${pair%% *}" # everything before the first space
  dest_path="${pair#* }" # everything after the first space
  ln -sfn "$DOTFILES_PATH/themes/current/$src_file" "$dest_path"
done
