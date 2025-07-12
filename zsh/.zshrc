# ~/.zshrc
# This file loads the zsh configuration by sourcing files from a hardcoded path.

# Define the absolute path to your configuration files directory using $HOME.
# This ensures the path is always resolved correctly.
ZSH_CONFIG_PATH="$HOME/dotfiles/zsh/.zsh"

# Source each configuration file directly.
# The order can be important, so exports and aliases are often loaded first.
source "${ZSH_CONFIG_PATH}/exports.zsh"
source "${ZSH_CONFIG_PATH}/aliases.zsh"
source "${ZSH_CONFIG_PATH}/functions.zsh"
source "${ZSH_CONFIG_PATH}/plugins.zsh"
source "${ZSH_CONFIG_PATH}/theme.zsh"

# Any other commands can go below.
