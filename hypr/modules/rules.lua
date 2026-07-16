-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more

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

-- windowrule = opacity 0.9, class:org.mozilla.firefox
-- hl.window_rule({
--     match = { class = "org.mozilla.firefox" },
--     opacity = 0.9,
-- })

-- Floating terminal
hl.window_rule({
    name  = "floating-terminal",
    match = { title = "^(floatingTerminal)$" },
    float = true,
    size  = { "60%", "60%" },
    center = true,
})

-- imv floating image viewer
hl.window_rule({
    name  = "imv-floating",
    match = { title = "^(imv_floating)$" },
    float = true,
    center = true,
})
