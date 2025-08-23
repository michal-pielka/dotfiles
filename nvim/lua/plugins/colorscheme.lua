return {
  {
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
	config = function()
		require('vague').setup({
			transparent = true,
		})
	end
  },

  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        contrast = 'hard',
        transparent_mode = true,
        terminal_colors = true,
        bold = false,
        italic = {
          strings = true,
          comments = true,
          operators = true,
          folds = false,
        },
        overrides = {
          Pmenu       = { bg = 'NONE' },
          NormalFloat = { bg = 'NONE' },
          FloatBorder = { bg = 'NONE' },
        },
      })
    end,
  },
}
