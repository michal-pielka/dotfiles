return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    require('tokyonight').setup({
      transparent = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        hl.Pmenu = { bg = "none" }
        -- hl.BlinkCmpMenuBorder = { fg = c.border_highlight or "#565f89" }
        -- hl.BlinkCmpDocBorder = { fg = c.border_highlight or "#565f89" }
        -- hl.BlinkCmpSignatureHelpBorder = { fg = c.border_highlight or "#565f89" }
      end,
    })
    vim.cmd.colorscheme 'tokyonight'
  end,
}
