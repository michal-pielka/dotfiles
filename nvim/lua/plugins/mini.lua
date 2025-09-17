return {
  'echasnovski/mini.nvim',
  version = false,       -- Use latest mini.* modules
  event = 'VeryLazy',    -- Load after startup to keep it snappy
  config = function()
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

	-- mini.diff — show git diff columns
	require('mini.diff').setup({})

    -- mini.pick + mini.extra — lightweight fuzzy picker
    require('custom.mini_pickers').setup_registry() -- my custom pickers
    require('mini.extra').setup()
    local pick = require('mini.pick')
	pick.setup({
		source = {
			show = pick.default_show,
		},
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

	map('<leader>F', '<CMD>Pick repository_files<CR>', 'Pick: search repository files')
	map('<leader>f', '<CMD>Pick files<CR>', 'Pick: search files')
	map('<leader>g', '<CMD>Pick grep_live<CR>', 'Pick: search grep')
	map('<leader>b', '<CMD>Pick buffers<CR>', 'Pick: search buffers')

	map('<leader>sn', '<CMD>Pick dotfiles<CR>', 'Pick: search dotfiles')
	map('<leader>ss', '<CMD>Pick pickers<CR>', 'Pick: search pickers')
    map('<leader>sg', '<CMD>Pick git_status<CR>', 'Pick: search git diff')
	map('<leader>sd', '<CMD>Pick diagnostic<CR>', 'Pick: search diagnostics')
	map('<leader>sh', '<CMD>Pick help<CR>', 'Pick: search help')
	map('<leader>sk', '<CMD>Pick keymaps<CR>', 'Pick: search keymaps')

  end,
}
