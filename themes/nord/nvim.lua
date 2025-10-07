return {
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = true
      vim.g.nord_italic = false

      require('nord').set()

      vim.api.nvim_set_hl(0, 'Normal',      { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'Pmenu',       { bg = 'NONE' })
    end,
  },
}
