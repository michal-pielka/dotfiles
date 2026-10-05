# Zcomet init
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# Loading/installing plugins
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load ohmyzsh plugins/git

function zvm_config() {
  # Bind 'jk' to escape from insert mode
  ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

  # Always start each new prompt in insert mode
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
}

# System clipboard for zsh-vi-mode (y/p syncs with Wayland clipboard)
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_CLIPBOARD_COPY_CMD='wl-copy'
ZVM_CLIPBOARD_PASTE_CMD='wl-paste -n'

# Rebind p/P to paste from system clipboard instead of internal kill ring
zvm_after_lazy_keybindings_commands+=(
  'zvm_bindkey vicmd "p" zvm_paste_clipboard_after'
  'zvm_bindkey vicmd "P" zvm_paste_clipboard_before'
)

zcomet load jeffreytse/zsh-vi-mode

zcomet compinit
