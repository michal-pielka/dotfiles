if [ ! -d ".git" ]; then
    echo "Please run this script from the root directory of the dotfiles repository."
    exit 1
fi

CONFIG_DIRS=(alacritty hypr foot starship waybar fuzzel mako tealdeer eza git nvim)

CWD=$(pwd)
for config_dir in "${CONFIG_DIRS[@]}"; do
	SOURCE="$CWD/$config_dir"
	TARGET="$HOME/.config/$config_dir"

	echo "Processing: $config_dir"

	if [ ! -e "$SOURCE" ]; then
		echo "  Source directory not found: $SOURCE"
		continue
	fi

	if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
		if [ -L "$TARGET" ] && [ "$(readlink -f "$TARGET")" = "$SOURCE" ]; then
			echo "  $config_dir already linked correctly"
			continue
		fi

		echo "  Target already exists: $TARGET"
		read -p "  Do you want to overwrite? [Y/n]: " -n 1 -r
		echo

		if [[ ! $REPLY =~ ^[Yy]$ ]]; then
			echo "  Skipped."
			continue
		fi

		rm -rf "$TARGET"
		echo "  Removed existing target"
	fi

	ln -s "$SOURCE" "$TARGET"
	echo "  Created symlink: $TARGET -> $SOURCE"
done

echo ""
echo "Symlink setup complete!"
