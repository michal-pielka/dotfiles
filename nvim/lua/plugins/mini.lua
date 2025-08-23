return {
  'echasnovski/mini.nvim',
  version = false,       -- Use latest mini.* modules
  event = 'VeryLazy',    -- Load after startup to keep it snappy
  config = function()
    -- mini.ai — better textobjects (around/inside quotes, brackets, etc.)
    require('mini.ai').setup({
      n_lines = 500,
    })

    -- mini.pairs — lightweight autopairs
    require('mini.pairs').setup({
    })

    -- mini.jump — enhanced f/F/t/T with consistent ; and , repeats
    require('mini.jump').setup({
      -- highlight = { delay = 0 },
    })

    -- mini.statusline — simple, fast statusline
    require('mini.statusline').setup({
      use_icons = vim.g.have_nerd_font == true, -- Set this global elsewhere if you have Nerd Font
      set_vim_settings = true,                  -- Apply recommended statusline options
    })
  end,
}
