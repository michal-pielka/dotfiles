hl.config({
	general = {
		col = {
			active_border = "rgb(ebdbb2)",
			inactive_border = "rgb(272727)",
		},

		gaps_in = 4,
		gaps_out = 7,

		border_size = 2,

		resize_on_border = true,
		layout = "dwindle",

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,
	},

	decoration = {
		rounding = 0,

		blur = {
			enabled = true,
			size = 10,
			passes = 3,
		},
	},

	-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
	dwindle = {
		preserve_split = true,
		force_split = 2
	},

	misc = {
		disable_hyprland_logo = true,
	}
})
