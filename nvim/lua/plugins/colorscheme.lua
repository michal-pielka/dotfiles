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
    }
    vim.cmd.colorscheme 'gruvbox'
  end,
}
