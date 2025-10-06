return {
  {
    'Shatur/neovim-ayu',
    lazy = false,
    priority = 1000,
    config = function()
      require('ayu').setup({
        mirage = false, -- Ayu Dark
        -- You can add overrides here if needed
      })

      -- Set colorscheme to Ayu
      require('ayu').colorscheme()

      -- Transparency, similar to your gruvbox setup
      vim.api.nvim_set_hl(0, 'Normal',      { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'Pmenu',       { bg = 'NONE' })
    end,
  },
}
