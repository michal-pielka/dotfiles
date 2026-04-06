return {
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

      -- Set colorscheme to gruvbox
      vim.cmd.colorscheme('gruvbox')

      vim.api.nvim_set_hl(0, 'StatusLine',  { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE' })
    end,
  },
}
