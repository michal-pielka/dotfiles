#!/usr/bin/env bash


# Simple installer: install a small Wayland / terminal stack.

# Supported DISTRO values (edit below or pass --distro=...):
#   arch | fedora | debian | ubuntu

# Packages installed (attempted):
#   btop eza foot git hyprland neovim waybar

# Usage:
#   1. Adjust DISTRO variable below OR run: ./install_stack.sh --distro=arch
#   2. chmod +x install_desktop_stack.sh
#   3. ./install_desktop_stack.sh


set -euo pipefail

DISTRO="fedora"          # arch | fedora | debian | ubuntu
NON_INTERACTIVE="false"  # (reserved; no prompts right now)

PACKAGES=(btop eza foot git hyprland neovim waybar)

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
