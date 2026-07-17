-- You'll probably like this — suppress maximize events from all apps
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Layer rules
hl.layer_rule({
    match = { namespace = "launcher" },
    blur = true,
})

hl.layer_rule({
    match = { namespace = "notifications" },
    blur = true,
    ignore_alpha = 1,   -- equivalent to old `ignorezero`
})

-- Floating terminal
hl.window_rule({
    match = { title = "^(floatingTerminal)$" },
    float = true,
    center = true,
    size  = { "monitor_w * 0.6", "monitor_h * 0.6" },
})

-- imv floating image viewer
hl.window_rule({
    match = { title = "^(imv_floating)$" },
    float = true,
    center = true,
})
