return {
  'echasnovski/mini.nvim',
  version = false,       -- Use latest mini.* modules
  event = 'VeryLazy',    -- Load after startup to keep it snappy
  config = function()
    -- mini.ai — better textobjects (around/inside quotes, brackets, etc.)
    require('mini.ai').setup({
      n_lines = 500,
    })

    -- mini.pairs — lightweight autopairs
    require('mini.pairs').setup({})

    -- mini.jump — enhanced f/F/t/T with consistent ; and , repeats
    require('mini.jump').setup({
      -- highlight = { delay = 0 },
    })

    -- mini.statusline — simple, fast statusline
    require('mini.statusline').setup({
      use_icons = vim.g.have_nerd_font == true, -- Set this global elsewhere if you have Nerd Font
      set_vim_settings = true,                  -- Apply recommended statusline options
    })

	-- mini.files — file explorer, replacement for oil
	require('mini.files').setup({})

	-- mini.diff — show git diff columns
	require('mini.diff').setup({})

    -- mini.pick + mini.extra — lightweight fuzzy picker
    require('mini.extra').setup()
    require('mini.pick').setup({
		mappings = {
			move_down = '<C-j>',
			move_up = '<C-k>',
			move_start = '<C-g>',
			scroll_up = '<C-u>',
			scroll_down = '<C-d>',
		},
		options = {
			use_cache = true,

		}
	})

	map('<leader>f', '<CMD>Pick files<CR>', 'Pick: search files')
	-- map('<leader>F', '<CMD>Pick git_files<CR>', 'Pick: search project files')
	map('<leader>g', '<CMD>Pick grep_live<CR>', 'Pick: search grep')
	map('<leader>b', '<CMD>Pick buffers<CR>', 'Pick: search buffers')

	map('<leader>sc', '<CMD>Pick colorschemes<CR>', 'Pick: search colorschemes')
	map('<leader>sd', '<CMD>Pick diagnostic<CR>', 'Pick: search diagnostics')
	map('<leader>sh', '<CMD>Pick help<CR>', 'Pick: search help')
	map('<leader>sk', '<CMD>Pick keymaps<CR>', 'Pick: search keymaps')
  end,
}
