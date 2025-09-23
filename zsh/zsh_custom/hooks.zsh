function chpwd() {
	echo "$PWD" > $XDG_RUNTIME_DIR/last_cd_dir_$USER
}
