return {
  'sainnhe/gruvbox-material',
  priority = 1000,
  config = function()
    -- Gruvbox Material uses global variables for configuration
    vim.g.gruvbox_material_enable_italic = 0
    vim.g.gruvbox_material_transparent_background = 1
    vim.g.gruvbox_material_disable_italic_comment = 1
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_background = 'soft' -- or 'soft', 'hard'

    -- Set the colorscheme
    vim.cmd.colorscheme 'gruvbox-material'

    -- Custom highlights
    vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
  end,
}
