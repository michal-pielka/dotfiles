local vars = require("modules.vars")
local mainMod = vars.mainMod
local terminal = vars.terminal
local browser = vars.browser
local menu = vars.menu

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(terminal .. " --title floatingTerminal"))
hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special("scratch"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:scratch" }))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + X", hl.dsp.layout("togglesplit"))    -- dwindle

-- Move focus with mainMod + h/j/k/l
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Swap windows with mainMod + SHIFT + h/j/k/l
-- TODO(investigate): This is a conflict with moveactive binds below
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "right" }))

-- Move floating windows with mainMod + SHIFT + h/j/k/l
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ x = -15, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ x = 0, y = 15 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ x = 0, y = -15 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ x = 15, y = 0 }), { repeating = true })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Tab between last and current workspace
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Resize active window
hl.bind(mainMod .. " + code:20", hl.dsp.window.resize({ x = -15, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + code:21", hl.dsp.window.resize({ x = 15, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + code:20", hl.dsp.window.resize({ x = 0, y = 15, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + code:21", hl.dsp.window.resize({ x = 0, y = -15, relative = true }), { repeating = true })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = 1 }))

-- Media Control
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Volume Control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.dotfiles/scripts/volume.sh up"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.dotfiles/scripts/volume.sh down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("~/.dotfiles/scripts/volume.sh mute"), { locked = true })

-- Screen Brightness Control
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("~/.dotfiles/scripts/brightness.sh up"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.dotfiles/scripts/brightness.sh down"), { locked = true, repeating = true })

-- Keyboard Brightness Control
hl.bind("CTRL + XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl --device='*kbd_backlight*' set +5%"))
hl.bind("CTRL + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl --device='*kbd_backlight*' set 5%-"))

-- Enable/Disable touchpad
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("hyprctl keyword 'device[apple-spi-trackpad]:enabled' 'true'"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("hyprctl keyword 'device[apple-spi-trackpad]:enabled' 'false'"))

-- Screenshot - save to clipboard
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.dotfiles/scripts/screenshot_select.sh"))

-- Screen record - save to clipboard
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.dotfiles/scripts/screenrecord_select.sh"))

-- Toggle waybar
hl.bind(mainMod .. " + w", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
