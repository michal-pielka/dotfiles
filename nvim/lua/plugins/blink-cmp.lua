-- Autocompletion
return {
	'saghen/blink.cmp',
	event = 'VimEnter',
	version = '1.*',
	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'none',
			['<Up>'] = { 'select_prev', 'fallback' }, -- Meant to be used via ctrl + k keyd remap
			['<Down>'] = { 'select_next', 'fallback' }, -- Meant to be used via ctrl + j keyd remap
			['<CR>'] = { 'accept', 'fallback' },

			['<Tab>'] = { 'select_next', 'fallback' },
			['<S-Tab>'] = { 'select_prev', 'fallback' },
		},

		appearance = {
			nerd_font_variant = 'mono',
		},

		completion = {
			-- Apply styling to completion menu and documentation
			menu = {
				scrollbar = false,
				draw = {
					padding = { 1, 1 },
					columns = { { 'kind_icon', separator = ' ' }, { 'label', separator = ' ' }, { 'kind', separator = ' ' } },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 1500,
			},
		},

		cmdline = {
			keymap = {
				preset = 'inherit',
				['<CR>'] = { action = 'accept', execute = true, fallback = true },
			},
			completion = { menu = { auto_show = true } },
		},

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer', },
		},

		fuzzy = { implementation = 'lua' },

		-- Apply styling to signature help window
		signature = {
			enabled = true,
		},
	},
}
