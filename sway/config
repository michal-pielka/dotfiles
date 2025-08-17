# ===================================================
#  Translated from your Hyprland configuration
#  Focus: key bindings & core behavior (no animations/blur in sway)
# ===================================================

### Environment (Hyprland env.conf equivalents)
setenv XCURSOR_SIZE 10
setenv QT_QPA_PLATFORMTHEME qt5ct
# NVIDIA (only keep if you actually use the NV driver stack on Wayland)
setenv LIBVA_DRIVER_NAME nvidia
setenv GBM_BACKEND nvidia-drm

### Variables (aliases)
set $mod Mod4
set $terminal footclient
set $browser zen
set $menu rofi -show drun
set $wallpaper ~/Pictures/wallpapers/abs_bauhas.png

# (Optional) use a variable for touchpad device once you know it
# Run: swaymsg -t get_inputs  | grep -i touchpad -A4
# Then set (example):
# set $touchpad_id 1386:103:Apple_Internal_Keyboard_/_Trackpad

### Autostart (Hyprland exec-once)
# Use `exec` (*not* exec_always) so they only run on the first launch of this sway session.
exec dunst
exec /usr/lib/polkit-kde-authentication-agent-1
exec waybar
# Wallpaper (hyprpaper -> swaybg)
exec swaybg -i $wallpaper -m fill
# Foot server (optional; harmless if already running)
exec foot --server

### Look & feel (approximation of general.conf)
# Gaps
gaps inner 4
gaps outer 7

# Borders
default_border pixel 2
default_floating_border pixel 2

# Colors (mapping Hyprland active/inactive border colors)
set $bg        #1d2021
set $fg        #ebdbb2
set $inactive  #272727
set $accent    #ebdbb2

# client.<state>  border    background text     indicator child_border
client.focused   $accent    $bg        $fg      $accent   $accent
client.unfocused $inactive  $bg        $fg      $inactive $inactive
client.focused_inactive $inactive $bg $fg $inactive $inactive
client.urgent    #cc241d    $bg        $fg      #cc241d   #cc241d

# (Hyprland blur/rounding/animations cannot be replicated natively in sway.)

### Input (input.conf approximation)
# Keyboard
input type:keyboard {
    xkb_layout us
    repeat_delay 200
    repeat_rate 30
}

# Touchpad (adjust identifier to your device as needed)
# You can duplicate and refine once you know the real ID.
# Pointer accel in sway is roughly -1.0..1.0; using -0.13 from Hyprland sensitivity.
input type:touchpad {
    natural_scroll enabled
    tap enabled
    pointer_accel -0.13
}

# Mouse example (Hyprland had a per-device example; sway needs real identifiers)
# input "epic-mouse-v1" {
#     pointer_accel -0.5
# }

# Gestures: Hyprland workspace swipe has no native sway equivalent.
# Consider external tools (e.g. `sway-gestures`, `fusuma`, `touchegg`+bindings).

### Window rules (rules.conf approximation)
# Hyprland rule: suppress maximize events. Sway generally ignores client maximize requests
# so no direct equivalent is required. Add custom rules here if needed:
# for_window [class="^kitty$"] floating enable

### Key Bindings (binds.conf translation)

# Basic
bindsym $mod+Shift+q exec swaymsg exit
bindsym $mod+Return exec $terminal
bindsym $mod+b exec $browser
bindsym $mod+space exec $menu
# Extra launcher you had on $mod+SPACE (Hypr had two) -> choose one or add alternate:
# bindsym $mod+space exec ~/.config/rofi/launchers/type-2/launcher.sh

# Kill focused
bindsym $mod+q kill

# Floating toggle
bindsym $mod+f floating toggle

# Fullscreen (Hypr used $mod+M fullscreen,1)
bindsym $mod+m fullscreen toggle

# Focus movement (h/j/k/l)
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# Swap / move container (SHIFT + h/j/k/l)
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# Workspaces 1–10
bindsym $mod+1 workspace number 1
bindsym $mod+2 workspace number 2
bindsym $mod+3 workspace number 3
bindsym $mod+4 workspace number 4
bindsym $mod+5 workspace number 5
bindsym $mod+6 workspace number 6
bindsym $mod+7 workspace number 7
bindsym $mod+8 workspace number 8
bindsym $mod+9 workspace number 9
bindsym $mod+0 workspace number 10

# Previous / Next workspace (Hypr used i / o)
bindsym $mod+i workspace prev
bindsym $mod+o workspace next

# Move focused container to workspace (and stay)
bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5
bindsym $mod+Shift+6 move container to workspace number 6
bindsym $mod+Shift+7 move container to workspace number 7
bindsym $mod+Shift+8 move container to workspace number 8
bindsym $mod+Shift+9 move container to workspace number 9
bindsym $mod+Shift+0 move container to workspace number 10

# (Hyprland pseudo & togglesplit do not have sway equivalents – omitted.)

# Mouse drag move/resize (Hypr: bindm)
# --whole-window approximates Hypr’s behavior
bindsym --whole-window $mod+button1 move
bindsym --whole-window $mod+button3 resize

# Screenshot selection to clipboard
bindsym $mod+Shift+s exec grim -g "$(slurp)" - | wl-copy

# Volume (wpctl like Hypr)
bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindsym XF86AudioMute        exec wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle

# Brightness
bindsym XF86MonBrightnessUp   exec brightnessctl set 5%+
bindsym XF86MonBrightnessDown exec brightnessctl set 5%-

# Touchpad enable/disable (provide scripts below or use swaymsg directly)
# Using scripts keeps it simple; edit $touchpad_id inside scripts.
bindsym $mod+t exec ~/.config/sway/scripts/touchpad-enable.sh
bindsym $mod+Shift+t exec ~/.config/sway/scripts/touchpad-disable.sh

### Modes (optional) - none added; you can define resize mode if desired.

### Scratchpad (commented example if you want later)
# bindsym $mod+s move scratchpad
# bindsym $mod+Shift+s scratchpad show

### Floating criteria (optional)
# Assign some apps to floating by default:
# for_window [class="^pavucontrol$"] floating enable

### Misc (Hypr’s misc section analogs)
# No logos or splash in sway; nothing to disable.
# No direct equivalent to vfr or Hypr splash colors.

### Save session / reload (standard sway)
bindsym $mod+Shift+c reload
bindsym $mod+Shift+r restart

### END
