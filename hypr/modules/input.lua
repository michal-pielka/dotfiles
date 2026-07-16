hl.config({
    input = {
        kb_layout  = "us",

		repeat_rate = 30,
		repeat_delay = 200,

        follow_mouse = 1,

        sensitivity = -0.13, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
			scroll_factor = 0.3
        },
    },
})

hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "workspace"
})
