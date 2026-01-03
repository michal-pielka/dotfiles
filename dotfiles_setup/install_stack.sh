#!/usr/bin/env bash


set -euo pipefail

DISTRO="ubuntu"          # arch | fedora | debian | ubuntu
NON_INTERACTIVE="false"  # (reserved; no prompts right now)

PACKAGES=(
  hyprland
  hyprpaper
  hypridle
  hyprlock

  # Terminal
  foot

  # Shell and prompt
  zsh
  starship

  # Editor
  neovim

  # Status bar and notifications
  waybar
  mako

  # Application launcher
  fuzzel

  # File manager
  yazi

  # Browser
  firefox

  # System monitoring
  btop

  # File system tools
  fd-find
  ripgrep
  eza

  # Text processing
  bat
  jq

  # Fuzzy finder
  fzf

  # Wayland utilities
  wl-clipboard
  grim
  slurp
  wf-recorder

  # Audio/Media control
  playerctl
  wireplumber
  pipewire

  # Brightness control
  brightnessctl

  # Network tools
  network-manager

  # Git and GitHub
  git
  git-delta
  gh
  glow

  # Documentation
  tealdeer

  # Document viewer
  zathura

  # Typesetting
  typst

  # Image processing
  imagemagick

  # Authentication agent
  polkit-kde-agent-1

  # Keyboard remapping
  keyd

  # Calendar (optional)
  gcalcli

  # Python for venv
  python3
  python3-venv

  # Build tools
  curl
)

# Parse very small set of args
for arg in "$@"; do
  case "$arg" in
    --distro=*) DISTRO="${arg#*=}" ;;
    --non-interactive) NON_INTERACTIVE="true" ;;
    *) echo "Unknown argument: $arg" >&2; exit 1 ;;
  esac
done

if command -v sudo >/dev/null 2>&1; then
  SUDO="sudo"
else
  if [ "$(id -u)" -ne 0 ]; then
    echo "sudo not found and not running as root." >&2
    exit 1
  fi
  SUDO=""
fi

echo "[info] Using distro: $DISTRO"

install_arch() {
  $SUDO pacman -Sy --noconfirm
  for pkg in "${PACKAGES[@]}"; do
    echo "[arch] Installing $pkg"
    $SUDO pacman -S --needed --noconfirm "$pkg" || echo "[warn] Failed: $pkg"
  done
}

install_fedora() {
  $SUDO dnf makecache -y
  for pkg in "${PACKAGES[@]}"; do
    echo "[fedora] Installing $pkg"
    $SUDO dnf install -y "$pkg" || echo "[warn] Failed: $pkg"
  done
}

install_debian_or_ubuntu() {
  $SUDO apt-get update -y
  for pkg in "${PACKAGES[@]}"; do
    echo "[apt] Installing $pkg"
    # DEBIAN_FRONTEND just to suppress some interactive prompts if any.
    DEBIAN_FRONTEND=noninteractive $SUDO apt-get install -y "$pkg" \
      || echo "[warn] Failed: $pkg"
  done
}

case "$DISTRO" in
  arch)   install_arch ;;
  fedora) install_fedora ;;
  debian) install_debian_or_ubuntu ;;
  ubuntu) install_debian_or_ubuntu ;;
  *)
    echo "Unsupported DISTRO value: $DISTRO" >&2
    exit 1
    ;;
esac
