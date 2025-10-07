return {
  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('onedarkpro').setup({
        options = {
          transparency = true,
        },
      })
      vim.cmd.colorscheme('onedark')

      vim.api.nvim_set_hl(0, 'Normal',      { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'Pmenu',       { bg = 'NONE' })
    end,
  },
}
