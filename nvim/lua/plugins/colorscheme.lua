return {
  -- Keep Vague installed (not applied by default)
  {
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
    config = false,
  },

  -- Standard Gruvbox with your settings
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
          strings = false,
          comments = false,
          operators = false,
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
