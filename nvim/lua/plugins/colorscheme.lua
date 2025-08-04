return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    require('gruvbox').setup {
      transparent_mode = true,
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
        emphasis = false,
      },
      bold = false,
      overrides = {
        Pmenu = { bg = 'none' },
        BlinkCmpMenuBorder = { fg = '#928374' }, -- for nvim-cmp, optional
        BlinkCmpDocBorder = { fg = '#928374' },
        BlinkCmpSignatureHelpBorder = { fg = '#928374' },
      },
    }
    vim.cmd.colorscheme 'gruvbox'
  end,
}
