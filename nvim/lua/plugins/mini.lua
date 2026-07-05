return {
  'echasnovski/mini.nvim',
  version = false,       -- Use latest mini.* modules
  event = 'VeryLazy',    -- Load after startup to keep it snappy
  config = function()
    require('mini.ai').setup({
      n_lines = 500,
    })

    -- mini.jump — enhanced f/F/t/T with consistent ; and , repeats
    require('mini.jump').setup({
      -- highlight = { delay = 0 },
    })

    -- mini.statusline — simple, fast statusline
	require('mini.statusline').setup({
		content = {
			active = function()
				local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
				local git           = MiniStatusline.section_git({ trunc_width = 40 })
				local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
				local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
				local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
				local location      = MiniStatusline.section_location({ trunc_width = 75 })
				local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })

				return MiniStatusline.combine_groups({
					{ hl = mode_hl,                 strings = { mode } },
					{ hl = 'StatusLine', strings = { git, diff, diagnostics } },
					'%<',        -- general truncate point
					{ hl = 'StatusLine', strings = { filename } },
					'%=',        -- start right-aligned area
					{ hl = 'StatusLine', strings = { lsp } },
					{ hl = mode_hl,                 strings = { location } },
				})
			end,

			inactive = function()
				local filename = MiniStatusline.section_filename({ trunc_width = 120 })
				return MiniStatusline.combine_groups({
					'%=', -- center the filename for inactive windows too
					{ hl = 'MiniStatuslineFilename', strings = { filename } },
					'%=',
				})
			end,
		},
	})

	-- mini.diff — show git diff columns
	require('mini.diff').setup({})
  end,
}
