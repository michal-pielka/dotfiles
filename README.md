<div align="center">

## dotfiles - **handcrafted configs for questionable efficiency**

<img src="assets/images/foot_screenshot.png" alt="Gruvbox desktop with ASCII volume OSD" width="90%" />

<p>
  <img src="https://img.shields.io/badge/Hyprland-d65d0e?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Neovim-98971a?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Zsh-458588?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Foot-b16286?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Gruvbox-3c3836?style=for-the-badge" />
</p>
<p>
  <img src="https://img.shields.io/badge/Asahi_Linux-supported-689d6a?style=flat-square&logo=apple&logoColor=white" />
  <img src="https://img.shields.io/badge/Ubuntu-supported-E95420?style=flat-square&logo=ubuntu&logoColor=white" />
  <img src="https://img.shields.io/github/license/michal-pielka/dotfiles?style=flat-square&color=928374" />
</p>

A Wayland-centric, keyboard-first development environment with sensible defaults
and a consistent Gruvbox theme across every tool.

</div>

---

## What's inside

| Area | Configs |
|---|---|
| Compositor | Hyprland, hyprpaper, hyprlock, hypridle |
| Terminals | foot, alacritty |
| Shell | zsh + zcomet, starship prompt, vi mode |
| Editor | Neovim (Lua): plugins, keymaps, LSP, autocommands |
| Desktop | waybar, fuzzel, mako, firefox |
| CLI | git, fzf, bat, eza, tealdeer, btop, delta |
| System | keyd, JetBrains Mono Nerd Font |

---

## Installation

```sh
git clone git@github.com:michal-pielka/dotfiles.git
cd dotfiles/dotfiles_setup
./setup.sh
```

The script installs common dependencies, symlinks selected modules into your
home directory, sets zsh as the default shell, and can install the fonts.
Review it before running.

---

## Personalization

Opinionated but readable. Fork it, copy what you need, and keep
machine-specific overrides out of version control.
