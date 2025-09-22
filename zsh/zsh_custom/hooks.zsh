function chpwd() {
	echo "$PWD" > /tmp/last_cd_dir_$USER
}
